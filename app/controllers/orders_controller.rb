class OrdersController < ApplicationController
	before_action :authenticate_admin!, only: [:new]

	def index 
		if admin_signed_in?
			@orders = Order.all
		elsif user_signed_in?
			@orders = Order.pending
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
			@order.dimension = @order.height * @order.length * @order.width
			@order.save
			redirect_to orders_path, notice: "Pedido feito com sucesso"
		else 
			flash.now[:notice] = "Falha ao cadastrar ao criar o novo pedido"
			render :new
		end
	end

	private
	 def format_documentation(cpf)
      cpf.destinatary_identification.insert(3, ".")
      cpf.destinatary_identification.insert(7, ".")
      cpf.destinatary_identification.insert(11, "-")
    end
end