class AddStatusToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :status, :integer, default: 0
  end
end
