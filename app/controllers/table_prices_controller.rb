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
    	redirect_to table_price_path(current_user.shipping_company_id), notice: "Nova linha adicionada com sucesso!"
		
		else 
			flash.now[:notice] = "Falha ao adicionar a nova linha de preço"
			render :new
		end
	end

	def search
	end

	def calculate
		@shipping_company = ShippingCompany.all
		@dimension = params[:length].to_d * params[:width].to_d * params[:height].to_d / 1000000
		@weight = params[:weight].to_d
		@distance = params[:distance].to_d
		@prices = []
		@dates = []
		defining_price
		@tables = []
		@prices.each do |ps|
			@tables << TablePrice.find(ps)
		end
	end

	private 
		def defining_price
			@shipping_company.each do |sc|
				last_price = 0
				id = 0
				sc.table_prices.each do |tp|
					if ((tp.minimum_weight <= @weight && @weight <= tp.max_weight) || 
					(tp.minimum_dimension <= @dimension && @dimension <= tp.max_dimension)) && 
					last_price < (@distance * tp.price)
						last_price = @distance * tp.price
						id = tp.id
					end
				end
				@prices << id

				sc.estimated_dates.each do |ed|
					if @distance >= ed.min_distance && @distance <= ed.max_distance
						@dates << ed.business_day
					end
				end
			end
		end
end