class AddStatusToTransportVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :transport_vehicles, :status, :integer, default:0
  end
end
