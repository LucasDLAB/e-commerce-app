class TransportVehicle < ApplicationRecord
  belongs_to :shipping_company, optional: true
  
  validates :brand,:year_manufacture,:payload,:identification_plate,:vehicle_model,
            :height,:length,:width, presence: true
  
  validates :identification_plate, uniqueness: true
  
  validates :payload, :height, :length, :width, comparison: { greater_than: 0}
  
  validates :payload, :height, :length, :width,:dimension, numericality: {allow_nil:true}

  validates :year_manufacture, comparison: {less_than_or_equal_to: Time.now.year}

  validates :identification_plate, format: {with: /[A-Z0-9]{7}/}

  validate :confirm_format

  private 
    def confirm_format
      count_alpha = 0
      count_num = 0
      if self.identification_plate.present?
        self.identification_plate.each_char do |t|
          if t.match(/[A-Z]/)
            count_alpha +=1
          else 
            count_num += 1
          end
        end
        if count_num != 3 || count_alpha != 4
            self.errors.add(:identification_plate, "deve possuir 4 letras e 3 números.")
          end 
      else
        self.errors.add(:identification_plate, "deve possuir 4 letras e 3 números.")
      end  
    end
end
