# frozen_string_literal: true

FactoryBot.define do
  factory :estimated_date do
    min_distance { Faker::Number.number(digits: 2) }
    max_distance { Faker::Number.number(digits: 3) }
    business_day { Faker::Number.number(digits: 1) }
  end
end
