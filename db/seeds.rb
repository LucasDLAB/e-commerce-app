# frozen_string_literal: true

linha = '-=' * 10

p linha
p 'Carregando Administrador'
Admin.create!(email: 'teste@sistemadefrete.com', password: 'password', name: 'Testing')
p linha
p 'Administrador pronto'

p linha
p 'Carregando Transportadora'
shipping_company = ShippingCompany.create!(brand_name: 'Ligeirinho LTDA', corporate_name: 'Ligeirinho',
                                           registration_number: '82508995983', email_domain: '@ligeiro.com',
                                           street: 'Carlos Reis', number: 152, state: 'RJ', city: 'São Gonçalo',
                                           distance: 50)
p linha
p 'Transportadora pronta'

p linha
p 'Carregando Usuário'
User.create!(email: 'teste@ligeiro.com', password: 'password', name: 'Testing')
p linha
p 'Usuário pronto'

p linha
p 'Carregando Veículo'
TransportVehicle.create!(brand: 'Mercedes', year_manufacture: 2017, payload: 9000,
                         identification_plate: 'AAAA000', vehicle_model: 'Atego',
                         height: 12, length: 33, width: 43, shipping_company_id: shipping_company.id)
p linha
p 'Veículo pronto'

p linha
p 'Carregando Linha de preço'
TablePrice.create!(minimum_weight: 10, max_weight: 50, minimum_height: 1,
                   max_height: 5, minimum_width: 1, max_width: 5,
                   minimum_length: 10, max_length: 15, price: 0.5, shipping_company_id: shipping_company.id)
p linha
p 'Linha de preço pronta'

p linha
p 'Carregando prazo estimado'
EstimatedDate.create!(min_distance: 10, max_distance: 100, business_day: 3, shipping_company_id: shipping_company.id)
p linha
p 'Prazo estimado pronto'
