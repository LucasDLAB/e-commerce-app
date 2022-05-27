class CreateEstimatedDates < ActiveRecord::Migration[7.0]
  def change
    create_table :estimated_dates do |t|
      t.integer :min_distance
      t.integer :max_distance
      t.integer :business_day

      t.timestamps
    end
  end
end
