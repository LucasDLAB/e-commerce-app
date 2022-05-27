class TablePrice < ApplicationRecord
  belongs_to :shipping_company, optional: true
  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length,:price, presence: true

  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length,:price, numericality: true
            
  validates :max_dimension, :minimum_dimension, numericality: {allow_nil:true}

  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length,:price, comparison: {greater_than: 0}
  
  validates :max_weight, comparison: {greater_than: :minimum_weight}
  
  validates :max_length, comparison: {greater_than: :minimum_length}
  
  validates :max_width, comparison: {greater_than: :minimum_width}
  
  validates :max_height, comparison: {greater_than: :minimum_height}
end
