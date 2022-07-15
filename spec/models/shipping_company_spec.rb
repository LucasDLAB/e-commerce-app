# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do
  describe '#valid' do
    it 'falso se os campos não forem únicos' do
      first_company = create(:shipping_company, brand_name: 'Quicksilver LTDA', corporate_name: 'Quicksilver',
                                                email_domain: '@quick.com')
      second_company = build(:shipping_company, brand_name: 'Quicksilver LTDA', corporate_name: 'Quicksilver',
                                                registration_number: first_company.registration_number, email_domain: '@quick.com')

      second_company.valid?
      result = second_company.valid?

      expect(result).to be false
      expect(second_company.errors[:brand_name]).to include('já está em uso')
      expect(second_company.errors[:corporate_name]).to include('já está em uso')
      expect(second_company.errors[:registration_number]).to include('já está em uso')
      expect(second_company.errors[:email_domain]).to include('já está em uso')
    end

    it 'falso se os campos estiverem vazios' do
      shipping_company = described_class.create

      shipping_company.valid?
      result = shipping_company.valid?

      expect(result).to be false
      expect(shipping_company.errors[:brand_name]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:corporate_name]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:registration_number]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:email_domain]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:street]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:number]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:state]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:city]).to include('não pode ficar em branco')
      expect(shipping_company.errors[:distance]).to include('não pode ficar em branco')
    end

    it 'falso se o campo Estado não for maiúscula' do
      shipping_company = build(:shipping_company, state: 'Rs')

      shipping_company.valid?
      result = shipping_company.errors.include?(:state)

      expect(result).to be true
      expect(shipping_company.errors[:state]).to include('não é válido')
    end

    it 'falso se o campo Estado possuir apenas uma letra' do
      shipping_company = build(:shipping_company, state: 'R')

      shipping_company.valid?
      result = shipping_company.errors.include?(:state)

      expect(result).to be true
      expect(shipping_company.errors[:state]).to include('não é válido')
    end

    it 'falso se o campo Estado possuir mais de duas letras' do
      shipping_company = build(:shipping_company, state: 'RSS')

      shipping_company.valid?
      result = shipping_company.errors.include?(:state)

      expect(result).to be true
      expect(shipping_company.errors[:state]).to include('não possui o tamanho esperado (2 caracteres)')
    end

    it 'falso se o campo Dominio de email possuir formato diferente de @...' do
      shipping_company = build(:shipping_company, email_domain: 'quick.com')

      shipping_company.valid?
      result = shipping_company.errors.include?(:email_domain)

      expect(result).to be true
      expect(shipping_company.errors[:email_domain]).to include('não é válido')
    end
  end
end
