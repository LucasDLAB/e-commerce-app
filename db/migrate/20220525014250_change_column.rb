class ChangeColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :transport_vehicles, :year_manufacture, :integer
    change_column :transport_vehicles , :payload , :integer
  end
end
