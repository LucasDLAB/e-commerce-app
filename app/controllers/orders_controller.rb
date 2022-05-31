class OrdersController < ApplicationController
	before_action :authenticate_admin!, only: [:new, :create]

	def index 
		if admin_signed_in?
			@orders = Order.all
		elsif user_signed_in?
			@orders = []
			Order.pending.each do |o|
				if o.wanted_companies != "" && o.wanted_companies.match(/\w+/)[0].to_i == current_user.shipping_company_id 
					@orders << o 
				end
			end
		else
			redirect_to root_path, notice: "É necessário ser um Administrador ou Usuário de transportadora para acessar esta página"
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
			redirect_to orders_path, notice: "Pedido feito com sucesso"
		else 
			flash.now[:notice] = "Falha ao cadastrar ao criar o novo pedido"
			render :new
		end
	end

	def show
		@order = Order.find(params[:id])
		format_documentation(@order)
		if admin_signed_in? || (user_signed_in? && current_user.shipping_company_id == @order.shipping_company_id)
		else
			redirect_to root_path, notice: "Apenas Administradores ou Usuários de transportadoras responsaveis por este pedido podem visualiza-lo"
		end
	end

	def choose_vehicle
		@order = Order.find(params[:id])
		shipping_company = ShippingCompany.find(current_user.shipping_company_id)
		@vehicles = []
		shipping_company.transport_vehicles.available.each do |v|
			if v.dimension > @order.dimension && v.payload > @order.weight
				@vehicles << v
			end
		end

		if @vehicles == []
			redirect_to root_path, notice: "Disponibilize um veículo com dimensão e capacidade máxima adequada"
		end
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

		redirect_to order_path(@order), notice: "Aguardando o pagamento do pedido"
	end

	private
	 def format_documentation(cpf)
      cpf.destinatary_identification.insert(3, ".")
      cpf.destinatary_identification.insert(7, ".")
      cpf.destinatary_identification.insert(11, "-")
    end

    def price(sc)
    	@higher_price = sc.min_price
    	sc.table_prices.each do |tp|
    		line_price = @order.destinatary_distance.to_d * tp.price
    		if ((tp.minimum_weight <= @order.weight && @order.weight <= tp.max_weight) || 
						(tp.minimum_dimension <= @order.dimension && @order.dimension <= tp.max_dimension))
							if @higher_price < line_price
								@higher_price = line_price
							end
				end
    	end
    	@higher_price
    end

    def date(sc)
    	sc.estimated_dates.each do |ed|
				if @order.destinatary_distance >= ed.min_distance && @order.destinatary_distance <= ed.max_distance
					return ed.business_day			
				end
			end
    end
end