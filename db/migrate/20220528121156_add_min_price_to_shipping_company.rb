class AddMinPriceToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :min_price, :decimal, default: 0
  end
end
