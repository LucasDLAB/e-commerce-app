# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_company do
    brand_name { Faker::Company.name }
    corporate_name { Faker::Company.industry }
    email_domain { "@#{Faker::Name.first_name}.com" }
    registration_number { CNPJ.generate }
    street { Faker::Address.street_name }
    number { Faker::Address.building_number.to_i }
    state { Faker::Address.state_abbr }
    city { Faker::Address.city }
    distance { Faker::Number.number(digits: 3) }
  end
end
