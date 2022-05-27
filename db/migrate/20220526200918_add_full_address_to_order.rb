class AddFullAddressToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :full_address, :string
  end
end
