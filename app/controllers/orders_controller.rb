# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  before_action :authenticate_user!, only: %i[choose_vehicle associate_shipping_company]

  def index
    if admin_signed_in?
      @orders = Order.all

    elsif user_signed_in?
      @orders = []
      wanted_orders
    else
      redirect_to root_path,
                  notice: 'É necessário ser um Administrador ou Usuário de transportadora para acessar esta página'
    end
  end

  def new
    @order = Order.new
  end

  def create
    order_params = params.require(:order).permit(:destinatary_name, :destinatary_identification,
                                                 :street, :city, :state, :number, :weight, :width,
                                                 :length, :height, :destinatary_distance)
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_path, notice: 'Pedido feito com sucesso'
    else
      flash.now[:alert] = 'Falha ao cadastrar ao criar o novo pedido'
      render :new
    end
  end

  def show
    if admin_signed_in? || (user_signed_in? && current_user.shipping_company_id == params[:id].to_i)
      @order = Order.find(params[:id])
    else
      message = 'Apenas Administradores ou Usuários de transportadoras responsaveis por este pedido podem visualiza-lo'
      redirect_to root_path,
                  notice: message
    end
  end

  def choose_vehicle
    @order = Order.find(params[:id])
    shipping_company = ShippingCompany.find(current_user.shipping_company_id)
    @vehicles = TransportVehicle.where('shipping_company_id = ? AND dimension >= ? AND payload >= ?',
                                       shipping_company.id, @order.dimension, @order.weight)

    return if @vehicles.present?

    redirect_to root_path, notice: 'Disponibilize um veículo com dimensão e capacidade máxima adequada'
  end

  def associate_shipping_company
    @order = Order.find(params[:id])
    @order.waiting!
    shipping_company = ShippingCompany.find(current_user.shipping_company_id)
    @order.collect_code = SecureRandom.alphanumeric(10).upcase
    @order.shipping_company_id = shipping_company.id
    @order.transport_vehicle_id = params[:vehicle]
    @order.order_price = price(shipping_company)
    @order.estimated_date = date(shipping_company)
    @order.save

    redirect_to order_path(@order), notice: 'Aguardando o pagamento do pedido'
  end

  private

  def price(shipping_company)
    @higher_price = shipping_company.min_price
    shipping_company.table_prices.each do |table_price|
      line_price = @order.destinatary_distance.to_d * table_price.price
      next unless (table_price.minimum_weight <= @order.weight && @order.weight <= table_price.max_weight) ||
                  (table_price.minimum_dimension <= @order.dimension && @order.dimension <= table_price.max_dimension)

      @higher_price = line_price if @higher_price < line_price
    end
    @higher_price
  end

  def date(shipping_company)
    estimated_date = EstimatedDate.where('shipping_company_id = ? AND min_distance <= ? AND max_distance >= ?',
                                         shipping_company.id, @order.destinatary_distance, @order.destinatary_distance)
    estimated_date.first.business_day
  end

  def wanted_orders
    Order.pending.each do |o|
      if o.wanted_companies != '' && o.wanted_companies.match(/\w+/)[0].to_i == current_user.shipping_company_id
        @orders << o
      end
    end
  end
end
