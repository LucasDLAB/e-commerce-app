class EstimatedDatesController < ApplicationController
	def new
		@estimated_date = EstimatedDate.new
	end

	def create
		estimated_date_params = params.require(:estimated_date).permit(:min_distance,:max_distance,
																																	 :business_day)
		@estimated_date = EstimatedDate.new(estimated_date_params)
		@estimated_date.shipping_company_id = current_user.shipping_company_id
		if @estimated_date.save
			redirect_to estimated_date_path(current_user.shipping_company_id), notice: "Nova linha de estimativa adicionada com sucesso"
		else
			flash[:notice] = "Falha ao adicionar a nova linha de estimativa"
			render :new
		end
	end

	def show
		@estimated_date_lines = []
		@endereco = ShippingCompany.find(params[:id])
		EstimatedDate.where(shipping_company_id: params[:id]).find_each do |ed|
			@estimated_date_lines << ed
		end
	end
end