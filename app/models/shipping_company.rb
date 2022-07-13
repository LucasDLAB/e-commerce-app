class ShippingCompany < ApplicationRecord
	enum status: {active:0, disable:2}
	has_many :users
	has_many :transport_vehicles
	has_many :table_prices 
	has_many :estimated_dates

	validates :distance,:brand_name, :corporate_name, :email_domain, :registration_number, :state, 
	          :street, :number, :city, presence:true

	validates :brand_name, :corporate_name, :email_domain, :registration_number, uniqueness: true

	validates :distance, comparison: {greater_than: 0}

	validates :number, :distance, numericality:true

	validates :state, length: {is:2}

  validates :state, format: {with:/[A-Z]{2}/}
  validates :email_domain, format: {with: /@\w.+/}

	validate :cnpj_validator

  after_validation :addressing, :min_tax

  private
		def cnpj_validator
			if CNPJ.valid?(registration_number, strict: true)
				register_id = CNPJ.new(registration_number)
				self.registration_number = register_id.formatted
			else
				errors.add(:registration_number, 'não é válido')
			end
		end

  	def min_tax
  		self.min_price = 7.29.to_d
  	end

  	def addressing
  		self.billing_address = "#{self.street} #{self.number} - #{self.city}, #{self.state}"
  	end
end
