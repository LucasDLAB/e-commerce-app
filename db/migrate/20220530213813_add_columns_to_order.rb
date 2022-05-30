class AddColumnsToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_price, :decimal
    add_column :orders, :estimated_date, :integer
  end
end
