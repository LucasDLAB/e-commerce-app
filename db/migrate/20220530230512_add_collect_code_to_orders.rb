class AddCollectCodeToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :collect_code, :string
  end
end
