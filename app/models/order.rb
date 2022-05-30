class Order < ApplicationRecord
  enum status: {pending: 0, refused:2, accepted:4, waiting:6, preparing:7,road:8,delivered:10}
  belongs_to :shipping_company, optional: true

  validates :destinatary_name, :destinatary_identification,:street, :city, :state, :number, 
            :weight, :width, :length, :height, :destinatary_distance, :order_code, presence: true
  
  validates :number,:weight, :width, :length, :height, :destinatary_distance, numericality: true

  validates :state, format: {with:/[A-Z]{2}/}

  validates :order_code, uniqueness: true

  validates :order_code, length: {is:15}
  validates :state, length: {is:2}
  
  after_validation :dimensioning,:addressing, :finding_companies
  before_validation :generate_code

  private
    def dimensioning
      self.dimension = (self.length.to_d * self.width.to_d * self.height.to_d) / 1000000
    end

    def addressing
      self.full_address = "#{self.street} #{self.number} - #{self.city}, #{self.state}"
    end

    def generate_code
      self.order_code = SecureRandom.alphanumeric(15).upcase
    end

    def finding_companies
      prices_id = []
      ShippingCompany.all.each do |sc|
        last_price = 0
        id = 0
        if sc.active? && sc.transport_vehicles.available.count > 0
          sc.table_prices.each do |tp|
            if ((tp.minimum_weight <= self.weight && self.weight <= tp.max_weight) || 
            (tp.minimum_dimension <= self.dimension && self.dimension <= tp.max_dimension)) && 
            last_price < (self.destinatary_distance.to_d * tp.price)
              last_price = self.destinatary_distance.to_d * tp.price
              id = tp.id
            end
          end
          if id != 0
            sc.estimated_dates.each do |ed|
              if self.destinatary_distance >= ed.min_distance && self.destinatary_distance <= ed.max_distance
                prices_id << [id,last_price]
              end
            end
          end
        end
      end

      prices_id = prices_id.sort_by(&:last)
      prices_id.each do |ps|
        ps.delete_at 1
      end

      self.wanted_companies = prices_id.join(" ")
    end
end
