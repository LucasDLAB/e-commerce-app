# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário da Transportadora registra uma nova estimativa de entrega' do
  it 'acessa o formulário de estimativa de entrega' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Adicionar uma nova linha de estimativa de entrega'

    expect(page).to have_field 'Distância mínima'
    expect(page).to have_field 'Distância máxima'
    expect(page).to have_field 'Dia(s) úteis'
    expect(page).to have_button 'Criar linha de estimativa'
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
    click_on 'Adicionar uma nova linha de estimativa de entrega'
    fill_in 'Distância mínima em Km', with: '1'
    fill_in 'Distância máxima em Km', with: '100'
    fill_in 'Dia(s) úteis', with: '2'
    click_on 'Criar linha de estimativa'

    expect(page).to have_content 'Nova linha de estimativa adicionada com sucesso'
    within 'table' do
      expect(page).to have_content 'Distância mínima'
      expect(page).to have_content '1.0 Km'
      expect(page).to have_content 'Distância máxima'
      expect(page).to have_content '100.0 Km'
      expect(page).to have_content 'Dia(s) úteis'
      expect(page).to have_content '2'
    end
  end

  it 'com campos vazios' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Adicionar uma nova linha de estimativa de entrega'
    fill_in 'Distância mínima', with: ''
    click_on 'Criar linha de estimativa'

    expect(page).to have_content 'Falha ao adicionar a nova linha de estimativa'
    expect(page).to have_content 'Distância mínima em Km não pode ficar em branco'
    expect(page).to have_content 'Distância máxima em Km não pode ficar em branco'
    expect(page).to have_content 'Dia(s) úteis não pode ficar em branco'
    expect(page).to have_content 'Distância mínima em Km não é um número'
    expect(page).to have_content 'Distância máxima em Km não é um número'
    expect(page).to have_content 'Dia(s) úteis não é um número'
    expect(page).to have_content 'Distância mínima em Km não pode ficar em branco'
    expect(page).to have_content 'Distância máxima em Km não pode ficar em branco'
    expect(page).to have_content 'Dia(s) úteis não pode ficar em branco'
    expect(page).to have_content 'Distância mínima em Km não pode ficar em branco'
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
    click_on 'Adicionar uma nova linha de estimativa de entrega'
    click_on 'Voltar para a página da transportadora'

    expect(page).to have_content 'Transportadora Ligeirinho'
  end
end
