class TransportVehiclesController < ApplicationController
	before_action :authenticate_user!

	def new
		@transport_vehicle = TransportVehicle.new
	end

	def create
		transport_vehicle_params = params.require(:transport_vehicle).permit(:brand,:year_manufacture,:payload,
																																				:identification_plate,:vehicle_model,
																																				:height,:length,:width)

		@transport_vehicle = TransportVehicle.new(transport_vehicle_params)
    @transport_vehicle.shipping_company_id = current_user.shipping_company_id
    if @transport_vehicle.save
    	@transport_vehicle.dimension = @transport_vehicle.height * @transport_vehicle.length * @transport_vehicle.width
			@transport_vehicle.save
			redirect_to shipping_company_path(@transport_vehicle.id), notice: "Veículo cadastrado com sucesso!"
		else 
			flash.now[:notice] = "Falha ao cadastrar o veículo"
			render :new
		end
	end
end