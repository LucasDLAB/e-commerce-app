class OrdersController < ApplicationController
	before_action :authenticate_admin!, only: [:new, :create]

	def index 
		if admin_signed_in?
			@orders = Order.all
		elsif user_signed_in?
			@orders = []
			Order.pending.each do |o|
				if o.wanted_companies.match(/\w+/)[0].to_i == current_user.shipping_company_id 
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
	end

	private
	 def format_documentation(cpf)
      cpf.destinatary_identification.insert(3, ".")
      cpf.destinatary_identification.insert(7, ".")
      cpf.destinatary_identification.insert(11, "-")
    end
end