# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nome deve começar com letras maiúsculas' do
    user = described_class.create(name: 'lucas', email: 'walter@ligeiro')

    user.valid?
    result = user.errors.include?(:name)

    expect(result).to be true
    expect(user.errors[:name]).to include('não é válido')
  end
end
