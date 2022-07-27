# frozen_string_literal: true

class TablePricesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :authenticate_admin!, only: %i[search calculate]

  def show
    @table_prices = []
    @endereco = ShippingCompany.find(params[:id])
    if admin_signed_in? || (user_signed_in? && current_user.shipping_company_id == @endereco.id)
      @table_prices = TablePrice.where(shipping_company_id: params[:id])

    else
      redirect_to root_path, notice: 'Página disponível apenas para Administradores ou Usuários desta Transportadora'
    end
  end

  def new
    @table_price_line = TablePrice.new
  end

  def create
    table_price_line_params = params.require(:table_price).permit(:minimum_weight, :max_weight, :minimum_height,
                                                                  :max_height, :minimum_width, :max_width,
                                                                  :minimum_length, :max_length, :price)
    @table_price_line = TablePrice.new(table_price_line_params)
    @table_price_line.shipping_company_id = current_user.shipping_company_id

    if @table_price_line.save
      redirect_to table_price_path(current_user.shipping_company_id), notice: 'Nova linha adicionada com sucesso!'

    else
      flash.now[:notice] = 'Falha ao adicionar a nova linha de preço'
      render :new
    end
  end

  def search; end

  def calculate
    if params[:weight] == '' || params[:height] == '' || params[:width] == '' || params[:length] == '' || params[:distance] == ''
      redirect_to search_table_prices_path, notice: 'É necessário preencher todos os campos para criar um orçamento'
    end

    setting_values

    @data = []
    @tables = []
    defining_price
  end

  private

  def defining_price
    ShippingCompany.active.each do |sc|
      higher_price = sc.min_price

      weight = TablePrice.where('shipping_company_id = ? AND ? BETWEEN minimum_weight AND max_weight', sc.id, @weight)

      dimension = TablePrice.where('shipping_company_id = ? AND ? BETWEEN minimum_dimension AND max_dimension', sc.id, @dimension)

      [weight.first, dimension.first].each do |t|
        higher_price = @distance * t.price if t.present? && higher_price < (@distance * t.price)
      end

      date = EstimatedDate.where('shipping_company_id = ? AND ? BETWEEN min_distance AND max_distance', sc.id, @distance)

      @data << [higher_price, date.first.business_day, sc.corporate_name] if date.present?
    end
  end
end
