class ShippingCompany < ApplicationRecord
	# presence
	validates :brand_name, :corporate_name, :email_domain, :registration_number, :state, :street, :number, :city, presence:true

	#uniqueness
	validates :brand_name, :corporate_name, :email_domain, :registration_number, presence: true

	#length
	validates :registration_number, length: {is:14}

	#format 
  validates :registration_number, format: {with:/[0-9]{14}/}

  after_save :addressing

  private
  	def addressing
  		self.billing_address = "Rua #{self.street} #{self.number} - #{self.city}, #{self.state}"
  	end
end
