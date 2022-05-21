class ShippingCompaniesController < ApplicationController
	def index
		@shipping_companies = ShippingCompany.all

		@shipping_companies.each do |sc|
			format_documentation(sc)
		end
	end

	def show
		if admin_signed_in?
			@shipping_company = ShippingCompany.find(params[:id])
			format_documentation(@shipping_company)
		else
			redirect_to root_path
		end
	end

	def new
		@shipping_company = ShippingCompany.new
	end

	def create
		shipping_company_params = params.require(:shipping_company).permit(:brand_name,:corporate_name,:street,:city,
                                      :email_domain,:registration_number, :state, :number)
		@shipping_company = ShippingCompany.new(shipping_company_params)
    if @shipping_company.save
    	@shipping_company.billing_address = "Rua #{@shipping_company.street} #{@shipping_company.number} - #{@shipping_company.city}, #{@shipping_company.state}"
			@shipping_company.save
			redirect_to shipping_company_path(@shipping_company.id), notice: "Transportadora cadastrada com sucesso!"
		else 
			flash.now[:notice] = "Falha ao cadastrar a Transportadora"
			render :new
		end
	end

	private
	 def format_documentation(cnpj)
      cnpj.registration_number.insert(2, ".")
      cnpj.registration_number.insert(6, ".")
      cnpj.registration_number.insert(10, "/")
      cnpj.registration_number.insert(15, "-")
    end
end