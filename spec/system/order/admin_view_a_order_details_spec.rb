require "rails_helper"

describe "Administrador acessa a página de detalhes de um pedido" do
	it "com sucesso" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com' , distance:100)
		allow(SecureRandom).to receive(:alphanumeric).and_return("ABCDEF123456789")
		Order.create!(destinatary_name:"João", destinatary_distance: 5000,destinatary_identification:'96719903047',
									street:"Rua Santa Teresa", city: "Rio de janeiro", number:24, state:"RJ", 
									weight:27, length:15, width:12,height:32,status:8)

		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with: "lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Pedidos"
		click_on "Pedido ABCDEF123456789"
		
		expect(page).to have_content "Pedido ABCDEF123456789"
		expect(page).to have_content "João"
		expect(page).to have_content "27.0 Kg"
		expect(page).to have_content "5000.0 Km"
		expect(page).to have_content "0.00576 m³"
		expect(page).to have_content "À caminho"
		expect(page).to have_content "967.199.030-47"
		expect(page).to have_content "Rua Santa Teresa 24 - Rio de janeiro, RJ"
	end
end
