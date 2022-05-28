class EstimatedDate < ApplicationRecord
	belongs_to :shipping_company
	validates :min_distance,:max_distance,:business_day, presence: true

	validates :min_distance,:max_distance,:business_day, numericality: true

	validates :min_distance,:max_distance,:business_day, comparison: {greater_than: 0}
	
	validates :min_distance, comparison: {less_than: :max_distance} 

	validates :min_distance, :max_distance, uniqueness: {scope: :shipping_company}

	after_validation :nulling_interval_conflict

	private
		def nulling_interval_conflict
      ed = EstimatedDate.all
      ed.each do |e|
        if e.shipping_company_id == self.shipping_company_id && self.id != e.id
          if self.min_distance > e.min_distance && self.min_distance < e.max_distance
            self.errors.add(:min_distance,"deve possuir valor maior ou inferior ao dos intervalos anteriores")
          elsif (self.min_distance < e.min_distance && self.max_distance > e.min_distance)
            self.errors.add(:min_distance,"não pode possuir intervalos que abrangem outros intervalos")
          end

          if self.max_distance > e.min_distance && self.max_distance < e.max_distance
            self.errors.add(:max_distance,"deve possuir valor maior ou inferior ao dos intervalos anteriores")
            self.errors.add(:max_distance,"não pode possuir intervalos que abrangem outros intervalos")
          end
        end
      end
    end
end
