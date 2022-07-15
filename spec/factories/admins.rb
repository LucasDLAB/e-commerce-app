# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    name { Faker::Name.name}
    password { 'password' }
  end
end
