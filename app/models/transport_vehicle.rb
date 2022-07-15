# frozen_string_literal: true

class TransportVehicle < ApplicationRecord
  enum status: { available: 0, broken: 2, delivery: 4 }

  belongs_to :shipping_company, optional: true

  validates :brand, :year_manufacture, :payload, :identification_plate, :vehicle_model,
            :height, :length, :width, presence: true

  validates :identification_plate, uniqueness: true

  validates :payload, :height, :length, :width, comparison: { greater_than: 0 }

  validates :payload, :height, :length, :width, numericality: true

  validates :dimension, numericality: { allow_nil: true }

  validates :year_manufacture, comparison: { less_than_or_equal_to: Time.zone.now.year }

  validates :identification_plate, format: { with: /[A-Z0-9]{7}/ }

  validate :confirm_format

  after_validation :dimensioning

  private

  def dimensioning
    self.dimension = (length.to_d * width.to_d * height.to_d) / 1_000_000
  end

  def confirm_format
    count_alpha = 0
    count_num = 0
    if identification_plate.present?
      identification_plate.each_char do |t|
        if /[A-Z]/.match?(t)
          count_alpha += 1
        else
          count_num += 1
        end
      end
      errors.add(:identification_plate, 'deve possuir 4 letras e 3 números.') if count_num != 3 || count_alpha != 4
    else
      errors.add(:identification_plate, 'deve possuir 4 letras e 3 números.')
    end
  end
end
