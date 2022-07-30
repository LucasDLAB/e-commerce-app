# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário da Transportadora acessa a página de pedidos' do
  it 'visualiza pedidos pendentes' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com',
                                                 distance: 100)
    create(:user, email: 'lucas@ligeiro.com')
    create(:transport_vehicle, payload: 9000, height: 12, length: 33,
                               width: 43, shipping_company_id: shipping_company.id, status: 0)
    create(:table_price, minimum_weight: 10, max_weight: 50, minimum_height: 1,
                         max_height: 35, minimum_width: 1, max_width: 5,
                         minimum_length: 10, max_length: 16, price: 0.5, shipping_company_id: shipping_company.id)
    create(:estimated_date, min_distance: 10, max_distance: 5100, business_day: 3,
                            shipping_company_id: shipping_company.id)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEF123456789')
    Order.create!(destinatary_name: 'João', destinatary_distance: 5000, destinatary_identification: '96719903047',
                  street: 'Rua Santa Teresa', city: 'Rio de janeiro', number: 24, state: 'RJ',
                  weight: 27, length: 15, width: 12, height: 32, status: 0)

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'lucas@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Pedidos'

    expect(page).to have_button 'Aceitar Pedido'
    expect(page).not_to have_content 'Pedido ABCDEF123456789'
  end

  it 'com pedidos pendentes' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', brand_name: 'Ligeirinho LTDA',
                                                 email_domain: '@ligeiro.com', distance: 100)
    create(:user, email: 'lucas@ligeiro.com')
    transport_vehicle = create(:transport_vehicle, identification_plate: 'AAAA000', vehicle_model: 'Atego',
                                                   payload: 9000, height: 12, length: 33,
                                                   width: 43, shipping_company_id: shipping_company.id, status: 0)
    create(:table_price, minimum_weight: 10, max_weight: 50, minimum_height: 1,
                         max_height: 35, minimum_width: 1, max_width: 5,
                         minimum_length: 10, max_length: 16, price: 0.5, shipping_company_id: shipping_company.id)
    create(:estimated_date, min_distance: 10, max_distance: 5100, business_day: 3,
                            shipping_company_id: shipping_company.id)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEF123456789')
    Order.create!(destinatary_name: 'João', destinatary_distance: 5000, destinatary_identification: '96719903047',
                  street: 'Rua Santa Teresa', city: 'Rio de janeiro', number: 24, state: 'RJ',
                  weight: 27, length: 15, width: 12, height: 32, status: 0)

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'lucas@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Pedidos'
    click_on 'Aceitar Pedido'
    select transport_vehicle.vehicle_model, from: 'Veículo'
    click_on 'Selecionar veículo'

    expect(page).to have_content 'Aguardando o pagamento do pedido'
    expect(page).to have_content 'Pedido ABCDEF123456789'
    expect(page).to have_content 'João'
    expect(page).to have_content '5000.0 Km'
    expect(page).to have_content '0.00576 m³'
    expect(page).to have_content '967.199.030-47'
    expect(page).to have_content 'Rua Santa Teresa 24 - Rio de janeiro, RJ'
    expect(page).to have_content 'Transportadora responsável'
    expect(page).to have_content 'Ligeirinho LTDA'
    expect(page).to have_content 'Veículo da entrega'
    expect(page).to have_content 'Atego'
    expect(page).to have_content 'Placa de identificação'
    expect(page).to have_content 'AAAA000'
    expect(page).to have_content 'Valor do pedido'
    expect(page).to have_content 'R$ 2.500,00'
    expect(page).to have_content 'Prazo estimado'
    expect(page).to have_content '3 dia(s) úteis'
    expect(page).to have_content 'Código de retirada'
  end

  it 'deve pertencer a esta Transportadora ou ser um Administrador' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', brand_name: 'Ligeirinho LTDA',
                                                 email_domain: '@ligeiro.com', distance: 100)
    create(:shipping_company, email_domain: '@quick.com')
    create(:user, email: 'lucas@quick.com')
    create(:transport_vehicle, identification_plate: 'AAAA000', vehicle_model: 'Atego',
                               payload: 9000, height: 12, length: 33,
                               width: 43, shipping_company_id: shipping_company.id, status: 0)
    create(:table_price, minimum_weight: 10, max_weight: 50, minimum_height: 1,
                         max_height: 35, minimum_width: 1, max_width: 5,
                         minimum_length: 10, max_length: 16, price: 0.5, shipping_company_id: shipping_company.id)
    create(:estimated_date, min_distance: 10, max_distance: 5100, business_day: 3,
                            shipping_company_id: shipping_company.id)
    order = Order.create!(destinatary_name: 'João', destinatary_distance: 5000,
                          destinatary_identification: '96719903047',
                          street: 'Rua Santa Teresa', city: 'Rio de janeiro', number: 24, state: 'RJ',
                          weight: 27, length: 15, width: 12, height: 32, status: 0)

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'lucas@quick.com'
    fill_in 'Senha', with: 'password'
    visit order_path(order.id)

    message = 'Apenas Administradores ou Usuários de transportadoras responsaveis por este pedido podem visualiza-lo'
    expect(page).to have_content message
  end

  it 'sem veículos disponíveis' do
    shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', brand_name: 'Ligeirinho LTDA',
                                                 email_domain: '@ligeiro.com', distance: 100)
    create(:user, email: 'lucas@ligeiro.com')
    create(:transport_vehicle, identification_plate: 'AAAA000', vehicle_model: 'Atego',
                               payload: 9000, height: 12, length: 33,
                               width: 43, shipping_company_id: shipping_company.id, status: 4)
    create(:table_price, minimum_weight: 10, max_weight: 50, minimum_height: 1,
                         max_height: 35, minimum_width: 1, max_width: 5,
                         minimum_length: 10, max_length: 16, price: 0.5, shipping_company_id: shipping_company.id)
    create(:estimated_date, min_distance: 10, max_distance: 5100, business_day: 3,
                            shipping_company_id: shipping_company.id)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEF123456789')
    order = Order.create!(destinatary_name: 'João', destinatary_distance: 5000, 
                          destinatary_identification: '96719903047',
                          street: 'Rua Santa Teresa', city: 'Rio de janeiro', number: 24, state: 'RJ',
                          weight: 27, length: 15, width: 12, height: 32, status: 0)

    visit root_path
    click_on 'Entrar como colaborador de uma Transportadora'
    fill_in 'E-mail', with: 'lucas@ligeiro.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Pedidos'
    visit choose_vehicle_order_path(order.id)

    expect(page).to have_content 'Disponibilize um veículo com dimensão e capacidade máxima adequada'
  end
end
