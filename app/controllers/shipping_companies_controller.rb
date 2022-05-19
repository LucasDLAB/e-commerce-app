class ShippingCompaniesController < ApplicationController
	def index
		@shipping_companies = ShippingCompany.all

		@shipping_companies.each do |sc|
			format_documentation(sc)
		end
	end

	def show
	end

	private
	 def format_documentation(cnpj)
      cnpj.registration_number.insert(2, ".")
      cnpj.registration_number.insert(6, ".")
      cnpj.registration_number.insert(10, "/")
      cnpj.registration_number.insert(15, "-")
    end
end