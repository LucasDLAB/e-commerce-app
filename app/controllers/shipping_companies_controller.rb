class ShippingCompaniesController < ApplicationController
	def index
		@shipping_companies = ShippingCompany.all
	end

	def show
	end
end