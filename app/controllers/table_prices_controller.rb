class TablePricesController < ApplicationController
	def new
		@table_price_line = TablePrice.new
	end

	def create
	end
end