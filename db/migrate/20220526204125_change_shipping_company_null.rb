class ChangeShippingCompanyNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:orders, :shipping_company_id, true)
  end
end
