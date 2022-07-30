# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário da Transportadora acessa a página de detalhes do veículo' do
  it 'acessa a página com todos os veículos cadastrados' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')
    create(:transport_vehicle, brand: 'Mercedes', identification_plate: 'AAAA000', year_manufacture: 2017,
                               vehicle_model: 'Atego', payload: 9000, height: 12, length: 33,
                               width: 43, shipping_company_id: shipping_company.id)
    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Veículos'

    expect(page).to have_content 'Frota da Transportadora Ligeirinho'
    expect(page).to have_content 'Marca do Veículo'
    expect(page).to have_content 'Mercedes'
    expect(page).to have_content 'Ano de fabricação'
    expect(page).to have_content '2017'
    expect(page).to have_content 'Modelo do Veículo'
    expect(page).to have_content 'Atego'
    expect(page).to have_content 'Placa de identificação'
    expect(page).to have_content 'AAAA000'
    expect(page).to have_content 'Capacidade máxima'
    expect(page).to have_content '9000'
    expect(page).to have_content 'Metragem Cúbica'
    expect(page).to have_content '0.017028 m³'
    expect(page).to have_content 'Status do Veículo'
    expect(page).to have_content 'Na garagem'
  end

  it 'deve pertencer a esta Transportadora ou ser um Administrador' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:shipping_company, corporate_name: 'QuickSilver', email_domain: '@quick.com')
    create(:user, email: 'walter@quick.com')
    vehicle = create(:transport_vehicle, brand: 'Mercedes', identification_plate: 'AAAA000', year_manufacture: 2017,
                                         vehicle_model: 'Atego', payload: 9000, height: 12, length: 33,
                                         width: 43, shipping_company_id: shipping_company.id)
    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@quick.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    visit transport_vehicle_path(vehicle.id)

    expect(page).to have_content 'Página disponível apenas para Administradores ou Usuários desta Transportadora'
  end

  it 'sem veículos cadastrados' do
    create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
    create(:user, email: 'walter@ligeiro.com')

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'walter@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Transportadora Ligeirinho'
    click_on 'Veículos'

    expect(page).to have_content 'Sem veículos registrados'
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
    click_on 'Veículos'
    click_on 'Voltar para a página da transportadora'

    expect(page).to have_content 'Transportadora Ligeirinho'
  end
end
