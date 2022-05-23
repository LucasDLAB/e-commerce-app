class AddAttributesToTransportVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :transport_vehicles, :dimension, :integer
    add_column :transport_vehicles, :height, :integer
    add_column :transport_vehicles, :length, :integer
    add_column :transport_vehicles, :width, :integer
  end
end
