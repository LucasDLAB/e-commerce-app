class AddAddressToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :street, :string
    add_column :shipping_companies, :city, :string
    add_column :shipping_companies, :number, :integer
    add_column :shipping_companies, :state, :string
  end
end
