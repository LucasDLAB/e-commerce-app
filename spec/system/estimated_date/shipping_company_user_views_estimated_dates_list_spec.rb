# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário da Transportadora acessa a página da Tabela de estimativa de entrega' do
  it 'sem linhas adicionadas' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Tabela de estimativa de entrega'

    expect(page).to have_content 'Tabela de estimativa de entrega não possui linhas adicionadas'
  end

  it 'com linhas adicionadas' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')
    create(:estimated_date, min_distance: 10, max_distance: 100, business_day: 3,
                            shipping_company_id: shipping_company.id)

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Tabela de estimativa de entrega'

    within 'table' do
      expect(page).to have_content 'Distância mínima'
      expect(page).to have_content '10.0 Km'
      expect(page).to have_content 'Distância máxima'
      expect(page).to have_content '100.0 Km'
      expect(page).to have_content 'Dia(s) úteis'
      expect(page).to have_content '3'
    end
  end

  it 'retorna à página da Transportadora' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')
    create(:estimated_date, min_distance: 10, max_distance: 100, business_day: 3,
                            shipping_company_id: shipping_company.id)

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Tabela de estimativa de entrega'
    click_on 'Voltar para a página da transportadora'

    expect(page).to have_content 'Transportadora Ligeirinho'
  end
end
