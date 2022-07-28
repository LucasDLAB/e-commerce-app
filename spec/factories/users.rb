# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    password { 'password' }
  end
end
