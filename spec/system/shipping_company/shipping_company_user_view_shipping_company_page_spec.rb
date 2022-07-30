# frozen_string_literal: true

require 'rails_helper'

describe 'Colaborador da Transportadora acessa a página de transportadora' do
  it 'com sucesso' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    click_on 'Criar um usuário'
    within 'form' do
      fill_in 'Nome', with: 'Lucas'
      fill_in 'E-mail', with: 'lucas@ligeiro.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Registrar'
    end
    click_on 'Transportadora Ligeirinho'

    expect(page).not_to have_content 'Entrar'
    expect(page).to have_content 'Transportadora Ligeirinho'
    expect(page).to have_content 'Razão Social'
    expect(page).to have_content shipping_company.brand_name
    expect(page).to have_content 'Número de registro'
    expect(page).to have_content shipping_company.registration_number
    expect(page).to have_content 'Endereço de faturamento'
    expect(page).to have_content shipping_company.billing_address
    expect(page).to have_content 'Distância em Km'
    expect(page).to have_content shipping_company.distance
  end

  it 'criar conta de colaborador de uma Transportadora' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    click_on 'Criar um usuário'
    fill_in 'Nome', with: 'Walter'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'senhadowalter'
    fill_in 'Confirme sua senha', with: 'senhadowalter'
    click_on 'Registrar'

    expect(page).to have_content 'Transportadora Ligeirinho'
  end

  it 'deve pertencer a Transportadora' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:shipping_company, email_domain: '@quick.com')
    create(:user, email: 'walter@quick.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@quick.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    visit shipping_company_path(shipping_company.id)

    expect(page).to have_content 'Acesso permitido apenas para Administradores ou Usuários desta Transportadora'
  end

  it 'deve estar logado' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')

    visit shipping_company_path(shipping_company.id)

    expect(page).to have_content 'Acesso permitido apenas para Administradores ou Usuários desta Transportadora'
  end
end
