class ShippingCompany < ApplicationRecord
	has_many :users
	has_many :transport_vehicles
	has_many :table_prices 
	# presence
	validates :distance,:brand_name, :corporate_name, :email_domain, :registration_number, :state, :street, :number, :city, presence:true

	#uniqueness
	validates :brand_name, :corporate_name, :email_domain, :registration_number, uniqueness: true

	#numericality
	validates :number, :distance, numericality:true

	#length
	validates :registration_number, length: {is:14}
	validates :state, length: {is:2}

	#format 
  validates :registration_number, format: {with:/[0-9]{14}/}
  validates :state, format: {with:/[A-Z]{2}/}
  validates :email_domain, format: {with: /@\w.+/}

  after_validation :addressing

  private
  	def addressing
  		self.billing_address = "#{self.street} #{self.number} - #{self.city}, #{self.state}"
  	end
end
