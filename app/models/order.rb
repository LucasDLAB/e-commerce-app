# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { pending: 0, refused: 2, waiting: 6, preparing: 7, road: 8, delivered: 10 }
  belongs_to :shipping_company, optional: true
  belongs_to :transport_vehicle, optional: true

  validates :destinatary_name, :destinatary_identification, :street, :city, :state, :number,
            :weight, :width, :length, :height, :destinatary_distance, :order_code, presence: true

  validates :number, :weight, :width, :length, :height, :destinatary_distance, numericality: true

  validates :state, format: { with: /[A-Z]{2}/ }

  validates :order_code, uniqueness: true

  validates :order_code, length: { is: 15 }
  validates :state, length: { is: 2 }
  validate :cpf_validator

  before_validation :generate_code
  after_validation :dimensioning, :addressing, :finding_companies

  private

  def cpf_validator
    if CPF.valid?(destinatary_identification, strict: true)
      register_id = CPF.new(destinatary_identification)
      self.destinatary_identification = register_id.formatted
    else
      errors.add(:destinatary_identification, 'não é válido')
    end
  end

  def dimensioning
    self.dimension = (length.to_d * width.to_d * height.to_d) / 1_000_000
  end

  def addressing
    self.full_address = "#{street} #{number} - #{city}, #{state}"
  end

  def generate_code
    self.order_code = SecureRandom.alphanumeric(15).upcase
  end

  def finding_companies
    prices_id = []
    ShippingCompany.all.find_each do |sc|
      last_price = 0
      id = 0
      if sc.active? && sc.transport_vehicles.available.count.positive?
        sc.table_prices.each do |tp|
          next unless ((tp.minimum_weight <= weight && weight <= tp.max_weight) ||
          (tp.minimum_dimension <= dimension && dimension <= tp.max_dimension)) &&
                      last_price < (destinatary_distance.to_d * tp.price)

          last_price = destinatary_distance.to_d * tp.price
          id = tp.id
        end
        if id != 0
          sc.estimated_dates.each do |ed|
            if destinatary_distance >= ed.min_distance && destinatary_distance <= ed.max_distance
              prices_id << [id, last_price]
            end
          end
        end
      end
    end

    prices_id = prices_id.sort_by(&:last)
    prices_id.each do |ps|
      ps.delete_at 1
    end

    self.wanted_companies = prices_id.join(' ')
  end
end
