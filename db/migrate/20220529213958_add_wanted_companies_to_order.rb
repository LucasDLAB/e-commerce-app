class AddWantedCompaniesToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :wanted_companies, :string
  end
end
