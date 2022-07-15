# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EstimatedDate, type: :model do
  describe '#valid' do
    it 'falso se os campos estiverem vazios' do
      ed = described_class.create

      expect(ed.errors[:min_distance]).to include('não pode ficar em branco')
      expect(ed.errors[:max_distance]).to include('não pode ficar em branco')
      expect(ed.errors[:business_day]).to include('não pode ficar em branco')
    end

    it 'falso se os campos não forem números' do
      shipping_company = create(:shipping_company)
      ed = described_class.create(min_distance: 'A', max_distance: 'A', business_day: 'A',
                                  shipping_company_id: shipping_company.id)

      expect(ed.errors[:min_distance]).to include('não é um número')
      expect(ed.errors[:max_distance]).to include('não é um número')
      expect(ed.errors[:business_day]).to include('não é um número')
    end

    it 'falso se os campos forem menores ou iguais à zero' do
      shipping_company = create(:shipping_company)
      ed = described_class.create(min_distance: 0, max_distance: 0, business_day: 0,
                                  shipping_company_id: shipping_company.id)

      expect(ed.errors[:min_distance]).to include('deve ser maior que 0')
      expect(ed.errors[:max_distance]).to include('deve ser maior que 0')
      expect(ed.errors[:business_day]).to include('deve ser maior que 0')
    end

    it 'falso se Distância máxima menor que Distância mínima' do
      shipping_company = build(:shipping_company, email_domain: '@test.com')
      ed = described_class.create(min_distance: 10, max_distance: 5, business_day: 1,
                                  shipping_company_id: shipping_company.id)

      expect(ed.errors[:min_distance]).to include('deve ser menor que 5.0')
    end

    it 'verdadeiro se o campo Distância máxima e Distância mínima for igual em Tabelas de diferentes transportadoras' do
      first_company = create(:shipping_company, email_domain: '@first.com')
      second_company = create(:shipping_company, email_domain: '@second.com')
      ed = described_class.create!(min_distance: 5, max_distance: 10, business_day: 1,
                                   shipping_company_id: first_company.id)

      second_ed = described_class.create(min_distance: 5, max_distance: 10, business_day: 1,
                                         shipping_company_id: second_company.id)

      result = second_ed.valid?

      expect(result).to be true
    end

    it 'falso se as Distãncia de estimativa possuir intervalos intercalados' do
      shipping_company = create(:shipping_company)
      ed = described_class.create(min_distance: 5, max_distance: 10, business_day: 1,
                                  shipping_company_id: shipping_company.id)
      second_ed = described_class.create(min_distance: 2, max_distance: 7, business_day: 1,
                                         shipping_company_id: shipping_company.id)

      expect(second_ed.errors[:min_distance]).to include('não pode possuir intervalos que abrangem outros intervalos')
      expect(second_ed.errors[:max_distance]).to include('não pode possuir intervalos que abrangem outros intervalos')
    end

    it 'falso se Distãncia de estimativa estiver entre intervalos' do
      shipping_company = create(:shipping_company)
      ed = described_class.create(min_distance: 5, max_distance: 10, business_day: 1,
                                  shipping_company_id: shipping_company.id)
      second_ed = described_class.create(min_distance: 6, max_distance: 11, business_day: 1,
                                         shipping_company_id: shipping_company.id)

      expect(second_ed.errors[:min_distance]).to include('deve possuir valor maior ou inferior ao dos intervalos anteriores')
    end
  end
end
