# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TablePrice, type: :model do
  describe '#valid' do
    it 'falso se os campos estiverem vazios' do
      tablablable = described_class.create

      expect(tablablable.errors[:minimum_weight]).to include('não pode ficar em branco')
      expect(tablablable.errors[:max_weight]).to include('não pode ficar em branco')
      expect(tablablable.errors[:minimum_height]).to include('não pode ficar em branco')
      expect(tablablable.errors[:minimum_length]).to include('não pode ficar em branco')
      expect(tablablable.errors[:minimum_width]).to include('não pode ficar em branco')
      expect(tablablable.errors[:max_height]).to include('não pode ficar em branco')
      expect(tablablable.errors[:max_length]).to include('não pode ficar em branco')
      expect(tablablable.errors[:max_width]).to include('não pode ficar em branco')
      expect(tablablable.errors[:price]).to include('não pode ficar em branco')
    end

    it 'falso se os campos forem menores ou iguais à 0' do
      table = described_class.create(minimum_weight: 0, max_weight: 0, minimum_height: 0,
                                     max_height: 0, minimum_width: 0, max_width: 0,
                                     minimum_length: 0, max_length: 0, price: 0, shipping_company_id: 1)

      result = table.valid?

      expect(result).to be false
      expect(table.errors[:minimum_weight]).to include('deve ser maior que 0')
      expect(table.errors[:max_weight]).to include('deve ser maior que 0')
      expect(table.errors[:max_height]).to include('deve ser maior que 0')
      expect(table.errors[:minimum_height]).to include('deve ser maior que 0')
      expect(table.errors[:minimum_width]).to include('deve ser maior que 0')
      expect(table.errors[:max_width]).to include('deve ser maior que 0')
      expect(table.errors[:max_length]).to include('deve ser maior que 0')
      expect(table.errors[:minimum_length]).to include('deve ser maior que 0')
      expect(table.errors[:price]).to include('deve ser maior que 0')
    end

    it 'falso se o campo Peso mínimo maior que Peso máximo' do
      tablable = described_class.create(minimum_weight: 100, max_weight: 50, minimum_height: 1,
                                        max_height: 5, minimum_width: 1, max_width: 5,
                                        minimum_length: 10, max_length: 15, price: 10)

      tablable.valid?
      result = tablable.errors.include?(:max_weight)

      expect(result).to be true
      expect(tablable.errors[:max_weight]).to include('deve ser maior que 100.0')
    end

    it 'falso se o campo Peso mínimo igual ao Peso máximo' do
      table = described_class.create(minimum_weight: 100, max_weight: 100, minimum_height: 1,
                                     max_height: 5, minimum_width: 1, max_width: 5,
                                     minimum_length: 10, max_length: 15, price: 10)

      table.valid?
      result = table.errors.include?(:max_weight)

      expect(result).to be true
      expect(table.errors[:max_weight]).to include('deve ser maior que 100.0')
    end

    it 'verdadeiro se o campo Dimensão máxima e Dimensão mínima for igual em Tabelas de diferentes transportadoras' do
      first_company = create(:shipping_company)
      second_company = create(:shipping_company)

      described_class.create!(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                              max_height: 5, minimum_width: 1, max_width: 5,
                              minimum_length: 10, max_length: 15, price: 10, shipping_company_id: first_company.id)

      second_table = described_class.create(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                                            max_height: 5, minimum_width: 1, max_width: 5,
                                            minimum_length: 10, max_length: 15, price: 10,
                                            shipping_company_id: second_company.id)
      result = second_table.valid?

      expect(result).to be true
    end

    it 'Dimensão mínima deve estar fora de intervalos cadastrados' do
      shipping_company = create(:shipping_company)
      described_class.create!(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                              max_height: 5, minimum_width: 1, max_width: 5,
                              minimum_length: 10, max_length: 15, price: 10, shipping_company_id: shipping_company.id,
                              minimum_dimension: 10, max_dimension: 375)
      second_table = described_class.create(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                                            max_height: 5, minimum_width: 1, max_width: 5,
                                            minimum_length: 11, max_length: 15, price: 10,
                                            shipping_company_id: shipping_company.id,
                                            minimum_dimension: 11, max_dimension: 400)
      result = second_table.valid?
      message = 'deve possuir valor maior ou inferior ao dos intervalos anteriores'

      expect(result).to be false
      expect(second_table.errors[:minimum_dimension]).to include(message)
    end

    it 'Dimensão máxima deve estar fora de intervalos cadastrados' do
      shipping_company = create(:shipping_company)
      described_class.create!(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                              max_height: 5, minimum_width: 1, max_width: 5,
                              minimum_length: 10, max_length: 15, price: 10, shipping_company_id: shipping_company.id)
      second_table = described_class.create(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                                            max_height: 5, minimum_width: 1, max_width: 5,
                                            minimum_length: 10, max_length: 14, price: 10,
                                            shipping_company_id: shipping_company.id)
      result = second_table.valid?
      message = 'não pode possuir intervalos que abrangem outros intervalos'

      expect(result).to be false
      expect(second_table.errors[:max_dimension]).to include(message)
    end

    it 'falso se possuir intervalos dentro de outros intervalos' do
      shipping_company = create(:shipping_company)
      described_class.create!(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                              max_height: 5, minimum_width: 1, max_width: 5,
                              minimum_length: 10, max_length: 15, price: 10,
                              shipping_company_id: shipping_company.id,
                              minimum_dimension: 10, max_dimension: 375)
      second_table = described_class.create(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                                            max_height: 5, minimum_width: 1, max_width: 5,
                                            minimum_length: 9, max_length: 15, price: 10,
                                            shipping_company_id: shipping_company.id,
                                            minimum_dimension: 9, max_dimension: 376)
      result = second_table.valid?
      message = 'não pode possuir intervalos que abrangem outros intervalos'

      expect(result).to be false
      expect(second_table.errors[:minimum_dimension]).to include(message)
    end

    it 'falso Dimensão máxima possuir parâmetros dentro de outros intervalos' do
      shipping_company = create(:shipping_company)
      described_class.create!(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                              max_height: 5, minimum_width: 1, max_width: 5,
                              minimum_length: 10, max_length: 15, price: 10,
                              shipping_company_id: shipping_company.id)
      second_table = described_class.create(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                                            max_height: 5, minimum_width: 1, max_width: 5,
                                            minimum_length: 9, max_length: 14, price: 10,
                                            shipping_company_id: shipping_company.id)
      result = second_table.valid?
      message = 'não pode possuir intervalos que abrangem outros intervalos'

      expect(result).to be false
      expect(second_table.errors[:max_dimension]).to include(message)
    end
  end
end
