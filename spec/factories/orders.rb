# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    destinatary_name { Faker::Name.name }
    destinatary_distance { Faker::Number.number(digits: 4) }
    destinatary_identification { CPF.generate }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    number { Faker::Address.building_number.to_i }
    state { Faker::Address.state_abbr }
    weight { Faker::Number.number(digits: 2)  }
    length { Faker::Number.number(digits: 2)  }
    width { Faker::Number.number(digits: 2) }
    height { Faker::Number.number(digits: 2) }
  end
end
