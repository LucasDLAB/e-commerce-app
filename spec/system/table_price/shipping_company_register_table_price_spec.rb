# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário da Transportadora cadastra uma nova linha na tabela de preço' do
  it 'acessa a página do formulário' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Adicionar linha na tabela de preço'

    expect(page).to have_field 'Peso mínimo em Kg'
    expect(page).to have_field 'Peso máximo em Kg'
    expect(page).to have_field 'Altura máxima em cm'
    expect(page).to have_field 'Altura mínima em cm'
    expect(page).to have_field 'Largura máxima em cm'
    expect(page).to have_field 'Largura mínima em cm'
    expect(page).to have_field 'Comprimento máximo em cm'
    expect(page).to have_field 'Comprimento mínimo em cm'
    expect(page).to have_field 'Preço por Km'
  end

  it 'com sucesso' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Adicionar linha na tabela de preço'
    fill_in 'Peso mínimo', with: 10.4
    fill_in 'Peso máximo', with: 50
    fill_in 'Altura mínima', with: 1
    fill_in 'Altura máxima', with: 5
    fill_in 'Largura mínima', with: 1
    fill_in 'Largura máxima', with: 5
    fill_in 'Comprimento mínimo', with: 10
    fill_in 'Comprimento máximo', with: 15
    fill_in 'Preço por Km', with: 0.5
    click_on 'Adicionar linha'

    expect(page).to have_content 'Nova linha adicionada com sucesso!'
    expect(page).to have_content 'De 0.00001 a 0.000375'
    expect(page).to have_content 'De 10.4 a 50.0'
    expect(page).to have_content 'R$ 0,50'
  end

  it 'com dados vazios' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Adicionar linha na tabela de preço'
    fill_in 'Peso mínimo', with: ''
    click_on 'Adicionar linha'

    expect(page).to have_content 'Falha ao adicionar a nova linha'
  end

  it 'retorna à página da Transportadora' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Adicionar linha na tabela de preço'
    click_on 'Voltar para a página da transportadora'

    expect(page).to have_content 'Transportadora Ligeirinho'
  end
end
