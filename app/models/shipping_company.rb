class ShippingCompany < ApplicationRecord
	# presence
	validates :brand_name, :corporate_name, :email_domain, :registration_number, :billing_address, presence:true

	#uniqueness
	validates :brand_name, :corporate_name, :email_domain, :registration_number, :billing_address, presence: true

	#length
	validates :registration_number, length: {is:14}

	#format 
  validates :registration_number, format: {with:/[0-9]{14}/}
end
