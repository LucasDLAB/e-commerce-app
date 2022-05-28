class AddShippingCompanyReferenceToEstimatedDate < ActiveRecord::Migration[7.0]
  def change
    add_reference :estimated_dates, :shipping_company, null: false, foreign_key: true
  end
end
