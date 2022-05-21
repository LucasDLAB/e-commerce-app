class CreateTransportVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :transport_vehicles do |t|
      t.string :brand
      t.string :year_manufacture
      t.string :payload
      t.string :vehicle_model
      t.string :identification_plate
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
