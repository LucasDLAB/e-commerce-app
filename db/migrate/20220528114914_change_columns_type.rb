class ChangeColumnsType < ActiveRecord::Migration[7.0]
  def up
    #shipping company
    change_column :shipping_companies, :distance, :decimal
    
    #estimated date
    change_column :estimated_dates, :max_distance, :decimal
    change_column :estimated_dates, :min_distance, :decimal

    #order
    change_column :orders, :weight, :decimal
    change_column :orders, :length, :decimal
    change_column :orders, :height, :decimal
    change_column :orders, :width, :decimal
    change_column :orders, :dimension, :decimal
    change_column :orders, :destinatary_distance, :decimal
 
    #table price
    change_column :table_prices, :minimum_weight, :decimal
    change_column :table_prices, :max_weight, :decimal
    change_column :table_prices, :minimum_height, :decimal
    change_column :table_prices, :max_height, :decimal
    change_column :table_prices, :minimum_length, :decimal
    change_column :table_prices, :max_length, :decimal
    change_column :table_prices, :minimum_width, :decimal
    change_column :table_prices, :max_width, :decimal
    change_column :table_prices, :minimum_dimension, :decimal
    change_column :table_prices, :max_dimension, :decimal
    
    #transport vehicle
    change_column :transport_vehicles, :dimension, :decimal
    change_column :transport_vehicles, :payload, :decimal
    change_column :transport_vehicles, :height, :decimal
    change_column :transport_vehicles, :length, :decimal
    change_column :transport_vehicles, :width, :decimal
  end
end
