class CreateTablePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :table_prices do |t|
      t.integer :minimum_weight
      t.integer :max_weight
      t.integer :minimum_dimension
      t.integer :max_dimension
      t.integer :max_height
      t.integer :minimum_height
      t.integer :max_width
      t.integer :minimum_width
      t.integer :max_length
      t.integer :minimum_length
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
