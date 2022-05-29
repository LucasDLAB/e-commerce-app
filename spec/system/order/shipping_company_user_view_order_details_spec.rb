require "rails_helper"

describe "Usuário da Transportadora acessa a página de pedidos" do
	it "com detalhes" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:100)
		User.create!(email:"lucas@ligeiro.com",password:"password",name:"Lucas")
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
		click_on "Pedido ABCDEF123456789"
		
		expect(page).to have_content "Pedido ABCDEF123456789"
		expect(page).not_to have_content "João"
		expect(page).to have_content "5000.0 Km"
		expect(page).to have_content "0.00576 m³"
		expect(page).to have_content "Pendente de aceite"
		expect(page).not_to have_content "000.000.000-00"
		expect(page).not_to have_content "Rua Santa Teresa 24 - Rio de janeiro, RJ"
	end
end