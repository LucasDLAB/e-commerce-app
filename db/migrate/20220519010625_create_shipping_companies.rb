class CreateShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_companies do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :email_domain

      t.timestamps
    end
  end
end
