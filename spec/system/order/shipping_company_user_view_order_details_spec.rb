require "rails_helper"

describe "Usuário da Transportadora acessa a página de pedidos" do
	it "visualiza pedidos pendentes" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:100)
		User.create!(email:"lucas@ligeiro.com",password:"password",name:"Lucas")
		transport_vehicle = TransportVehicle.create!(brand: "Mercedes",year_manufacture: 2017,payload: 9000,
											 identification_plate:"AAAA000",vehicle_model:"Atego",
											 height:12,length:33,width:43, shipping_company_id:1,status:0)
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:35,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:16,price:0.5,shipping_company_id:1)
		EstimatedDate.create!(min_distance:10 , max_distance:5100, business_day: 3,shipping_company_id:1)
		allow(SecureRandom).to receive(:alphanumeric).and_return("ABCDEF123456789")
		Order.create!(destinatary_name:"João", destinatary_distance: 5000,destinatary_identification:"00000000000",
									street:"Rua Santa Teresa", city: "Rio de janeiro", number:24, state:"RJ", 
									weight:27, length:15, width:12,height:32,status:0)

		visit root_path 
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "lucas@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Pedidos"

		expect(page).to have_button "Recusar pedido"
		expect(page).to have_button "Aceitar Pedido"
		expect(page).not_to have_content "Pedido ABCDEF123456789"
	end

	it "com pedidos pendentes" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:100)
		User.create!(email:"lucas@ligeiro.com",password:"password",name:"Lucas")
		transport_vehicle = TransportVehicle.create!(brand: "Mercedes",year_manufacture: 2017,payload: 9000,
											 identification_plate:"AAAA000",vehicle_model:"Atego",
											 height:12,length:33,width:43, shipping_company_id:1,status:0)
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:35,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:16,price:0.5,shipping_company_id:1)
		EstimatedDate.create!(min_distance:10 , max_distance:5100, business_day: 3,shipping_company_id:1)
		allow(SecureRandom).to receive(:alphanumeric).and_return("ABCDEF123456789")
		Order.create!(destinatary_name:"João", destinatary_distance: 5000,destinatary_identification:"00000000000",
									street:"Rua Santa Teresa", city: "Rio de janeiro", number:24, state:"RJ", 
									weight:27, length:15, width:12,height:32,status:0)

		visit root_path 
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "lucas@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Pedidos"
		expect(page).to have_button "Recusar pedido"
		click_on "Aceitar Pedido"
		select transport_vehicle.vehicle_model, from: "Veículo"
		click_on "Selecionar veículo"
		
		expect(page).to have_content "Aguardando o pagamento do pedido"
		expect(page).to have_content "Pedido ABCDEF123456789"
		expect(page).to have_content "João"
		expect(page).to have_content "5000.0 Km"
		expect(page).to have_content "0.00576 m³"
		expect(page).to have_content "000.000.000-00"
		expect(page).to have_content "Rua Santa Teresa 24 - Rio de janeiro, RJ"
		expect(page).to have_content "Transportadora responsável"
		expect(page).to have_content "Ligeirinho LTDA"
		expect(page).to have_content "Veículo da entrega"
		expect(page).to have_content "Atego"
		expect(page).to have_content "Placa de identificação"
		expect(page).to have_content "AAAA000"
		expect(page).to have_content "Valor do pedido"
		expect(page).to have_content "R$ 2.500,00"
		expect(page).to have_content "Prazo estimado"	
		expect(page).to have_content "3 dia(s) úteis"
		expect(page).to have_content "Código de retirada"
	end
end