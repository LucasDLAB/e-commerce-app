# frozen_string_literal: true

class TransportVehiclesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def show
    @transport_vehicles = []
    @endereco = ShippingCompany.find(params[:id])
    if admin_signed_in? || (user_signed_in? && current_user.shipping_company_id == @endereco.id)
      TransportVehicle.where(shipping_company_id: params[:id]).find_each do |tv|
        @transport_vehicles << tv
      end
    else
      redirect_to root_path, notice: 'Página disponível apenas para Administradores ou Usuários desta Transportadora'
    end
  end

  def new
    @transport_vehicle = TransportVehicle.new
  end

  def create
    transport_vehicle_params = params.require(:transport_vehicle).permit(:brand, :year_manufacture, :payload,
                                                                         :identification_plate, :vehicle_model,
                                                                         :height, :length, :width)

    @transport_vehicle = TransportVehicle.new(transport_vehicle_params)
    @transport_vehicle.shipping_company_id = current_user.shipping_company_id
    if @transport_vehicle.save
      redirect_to transport_vehicle_path(current_user.id), notice: 'Veículo cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao cadastrar o veículo'
      render :new
    end
  end
end
