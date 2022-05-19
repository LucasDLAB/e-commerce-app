class AddBillingAddressToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :billing_address, :string
  end
end
