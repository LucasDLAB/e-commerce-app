class TablePricesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def show
		@table_prices = []
		@endereco = ShippingCompany.find(params[:id])
		TablePrice.where(shipping_company_id: params[:id]).find_each do |tp|
			@table_prices << tp
		end
	end
	
	def new
		@table_price_line = TablePrice.new
	end

	def create
		table_price_line_params = params.require(:table_price).permit(:minimum_weight,:max_weight,:minimum_height,
																																	:max_height,:minimum_width,:max_width,
																																	:minimum_length,:max_length,:price)
		@table_price_line = TablePrice.new(table_price_line_params)
		@table_price_line.shipping_company_id = current_user.shipping_company_id
    
    if @table_price_line.save
    	@table_price_line.save
    	redirect_to shipping_company_path(current_user.shipping_company_id), notice: "Nova linha adicionada com sucesso!"
		
		else 
			flash.now[:notice] = "Falha ao adicionar a nova linha de preço"
			render :new
		end
	end
end