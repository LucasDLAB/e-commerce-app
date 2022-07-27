# frozen_string_literal: true

require 'rails_helper'

describe 'Administrador acessa a página de transportadoras' do
  it 'sem transportadoras cadastradas' do
    create(:admin, email: 'lucas@sistemadefrete.com')

    visit root_path
    click_on 'Entrar como Administrador'
    fill_in 'E-mail', with: 'lucas@sistemadefrete.com'
    fill_in 'Senha', with: 'password'
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Transportadoras'

    expect(page).to have_content 'Transportadoras Filiadas'
    expect(page).to have_content 'Nenhuma transportadora cadastrada'
  end

  it 'com sucesso' do
    create(:admin, email: 'lucas@sistemadefrete.com')
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho')

    visit root_path
    click_on 'Entrar como Administrador'
    fill_in 'E-mail', with: 'lucas@sistemadefrete.com'
    fill_in 'Senha', with: 'password'
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Transportadoras'

    expect(page).to have_content 'Transportadoras Filiadas'
    expect(page).to have_content 'Ligeirinho'
    expect(page).to have_content shipping_company.registration_number
  end

  it 'criar conta de Administrador' do
    visit root_path
    click_on 'Entrar como Administrador'
    click_on 'Criar um administrador'
    fill_in 'Nome', with: 'Ana'
    fill_in 'E-mail', with: 'ana@sistemadefrete.com'
    fill_in 'Senha', with: 'senhadaana'
    fill_in 'Confirme sua senha', with: 'senhadaana'
    click_on 'Registrar'
    click_on 'Transportadoras'

    expect(page).to have_content 'Transportadoras Filiadas'
  end

  it 'desativa a transportadora' do
    create(:admin, email: 'lucas@sistemadefrete.com')
    create(:shipping_company, corporate_name: 'Ligeirinho')

    visit root_path
    click_on 'Entrar como Administrador'
    fill_in 'E-mail', with: 'lucas@sistemadefrete.com'
    fill_in 'Senha', with: 'password'
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Transportadoras'
    click_on 'Ligeirinho'
    click_on 'Desativar transportadora'

    expect(page).to have_content 'Status da Transportadora'
    expect(page).to have_content 'Desativada'
  end

  it 'ativa a transportadora' do
    create(:admin, email: 'lucas@sistemadefrete.com')
    create(:shipping_company, corporate_name: 'Ligeirinho', status: 2)

    visit root_path
    click_on 'Entrar como Administrador'
    fill_in 'E-mail', with: 'lucas@sistemadefrete.com'
    fill_in 'Senha', with: 'password'
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Transportadoras'
    click_on 'Ligeirinho'
    click_on 'Ativar transportadora'

    expect(page).to have_content 'Status da Transportadora'
    expect(page).to have_content 'Ativa'
  end
end
