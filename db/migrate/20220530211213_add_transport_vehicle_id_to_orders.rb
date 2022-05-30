class AddTransportVehicleIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :transport_vehicle, null: true, foreign_key: true
  end
end
