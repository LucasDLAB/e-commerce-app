class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :street
      t.string :city
      t.string :state
      t.integer :number
      t.integer :weight
      t.integer :length
      t.integer :height
      t.integer :width
      t.string :destinatary_name
      t.string :destinatary_identification
      t.references :shipping_company, null: false, foreign_key: true
      t.integer :dimension
      t.string :order_code
      t.integer :destinatary_distance

      t.timestamps
    end
  end
end
