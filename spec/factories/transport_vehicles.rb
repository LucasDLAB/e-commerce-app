# frozen_string_literal: true

def generate_plate
  plate = ''

  alpha = ('A'..'Z').to_a

  4.times { plate += alpha.sample }

  3.times { plate += rand(10).to_s }

  plate
end

FactoryBot.define do
  factory :transport_vehicle do
    brand { Faker::Vehicle.manufacture }
    year_manufacture { Date.current.year }
    payload { Faker::Number.number(digits: 4) }
    identification_plate { generate_plate }
    vehicle_model { Faker::Vehicle.model }
    height { Faker::Number.number(digits: 2) }
    length { Faker::Number.number(digits: 2) }
    width { Faker::Number.number(digits: 2) }
  end
end
