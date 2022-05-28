class Order < ApplicationRecord
  enum status: {pending: 0, refused:2, accepted:4, waiting:6, road:8,delivered:10}
  belongs_to :shipping_company, optional: true

  validates :destinatary_name, :destinatary_identification,:street, :city, :state, :number, 
            :weight, :width, :length, :height, :destinatary_distance, :order_code, presence: true
  
  validates :number,:weight, :width, :length, :height, :destinatary_distance, numericality: true

  validates :state, format: {with:/[A-Z]{2}/}

  validates :order_code, uniqueness: true

  validates :order_code, length: {is:15}
  validates :state, length: {is:2}
  
  after_validation :dimensioning,:addressing
  before_validation :generate_code

  private
    def dimensioning
      self.dimension = self.length.to_d * self.width.to_d * self.height.to_d
    end

    def addressing
      self.full_address = "#{self.street} #{self.number} - #{self.city}, #{self.state}"
    end

    def generate_code
      self.order_code = SecureRandom.alphanumeric(15).upcase
    end
end
