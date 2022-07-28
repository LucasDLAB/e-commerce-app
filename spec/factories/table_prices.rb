# frozen_string_literal: true

FactoryBot.define do
  factory :table_price do
    minimum_weight { Faker::Number.number(digits: 2) }
    max_weight { Faker::Number.number(digits: 3) }
    minimum_height { Faker::Number.number(digits: 2) }
    max_height { Faker::Number.number(digits: 3) }
    minimum_width { Faker::Number.number(digits: 2) }
    max_width { Faker::Number.number(digits: 3) }
    minimum_length { Faker::Number.number(digits: 2) }
    max_length { Faker::Number.number(digits: 3) }
    price { Faker::Number.number(digits: 3) }
  end
end
