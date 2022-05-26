class AddDistanceToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :distance, :integer
  end
end
