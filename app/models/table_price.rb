class TablePrice < ApplicationRecord
  belongs_to :shipping_company

  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length,:price, presence: true

  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length,:price, numericality: true
            
  validates :max_dimension, :minimum_dimension, numericality: {allow_nil:true}

  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length, :price, comparison: {greater_than: 0}

  validates :max_weight, comparison: {greater_than: :minimum_weight}
  
  validates :max_length, comparison: {greater_than: :minimum_length}
  
  validates :max_width, comparison: {greater_than: :minimum_width}
  
  validates :max_height, comparison: {greater_than: :minimum_height}

  validates :price, uniqueness: {scope: :shipping_company}

  after_validation :dimensioning

  after_validation :nulling_interval_conflict

  private
    def dimensioning
      self.max_dimension = (self.max_length.to_d * self.max_width.to_d * self.max_height.to_d) / 1000000
      self.minimum_dimension = (self.minimum_length.to_d * self.minimum_width.to_d * self.minimum_height.to_d) / 1000000
    end

    def nulling_interval_conflict
      tp = TablePrice.all
      tp.each do |t|
        if t.shipping_company_id == self.shipping_company_id && self.id != t.id
          if self.minimum_dimension > t.minimum_dimension && self.minimum_dimension < t.max_dimension
            self.errors.add(:minimum_dimension,"deve possuir valor maior ou inferior ao dos intervalos anteriores")
          elsif (self.minimum_dimension < t.minimum_dimension && self.max_dimension > t.minimum_dimension)
            self.errors.add(:minimum_dimension,"não pode possuir intervalos que abrangem outros intervalos")
          end

          if self.max_dimension > t.minimum_dimension && self.max_dimension < t.max_dimension
            self.errors.add(:max_dimension,"deve possuir valor maior ou inferior ao dos intervalos anteriores")
            self.errors.add(:max_dimension,"não pode possuir intervalos que abrangem outros intervalos")
          end
        end
      end
    end
end
