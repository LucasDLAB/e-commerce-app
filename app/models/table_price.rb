class TablePrice < ApplicationRecord
  belongs_to :shipping_company, optional: true
  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length,:price, presence: true
  validates :minimum_weight,:max_weight,:minimum_height,
            :max_height,:minimum_width,:max_width, 
            :minimum_length,:max_length,:price, comparison: {greater_than: 0}
end
