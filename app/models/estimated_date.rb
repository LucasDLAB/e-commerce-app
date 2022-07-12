class EstimatedDate < ApplicationRecord
  belongs_to :shipping_company
  validates :min_distance, :max_distance, :business_day, presence: true

  validates :min_distance, :max_distance, :business_day, numericality: true

  validates :min_distance, :max_distance, :business_day,
            comparison: { greater_than: 0 }

  validates :min_distance, comparison: { less_than: :max_distance }

  validates :min_distance, :max_distance,
            uniqueness: { scope: :shipping_company }

  validate :nulling_interval_conflict

  private

  def nulling_interval_conflict
    ed = EstimatedDate.where(shipping_company_id: shipping_company_id)
    
    ed.each do |e|   
      next if id == e.id
       
      if min_distance >= e.min_distance && min_distance <= e.max_distance
        errors.add(:min_distance,
                   'deve possuir valor maior ou inferior ao dos intervalos anteriores')
      elsif min_distance <= e.min_distance && max_distance >= e.min_distance
        errors.add(:min_distance,
                   'não pode possuir intervalos que abrangem outros intervalos')
      end

      next unless max_distance >= e.min_distance && max_distance <= e.max_distance

      errors.add(:max_distance,
                 'deve possuir valor maior ou inferior ao dos intervalos anteriores')
      errors.add(:max_distance,
                 'não pode possuir intervalos que abrangem outros intervalos')
    end
  end
end
