class AddAttributesToTablePrice < ActiveRecord::Migration[7.0]
  def change
    add_column :table_prices, :price, :decimal
  end
end
