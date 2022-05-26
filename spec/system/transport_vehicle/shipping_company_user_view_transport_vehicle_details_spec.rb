require "rails_helper"

describe "Usuário da Transportadora acessa a página de detalhes do veículo" do
	it "acessa a página'com todos os veículos cadastrados" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")
		TransportVehicle.create!(brand: "Mercedes",year_manufacture: 2017,payload: 9000,
											 identification_plate:"AAAA000",vehicle_model:"Atego",
											 height:12,length:33,width:43, shipping_company_id:1)
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Veículos"

		expect(page).to have_content "Frota da Transportadora Ligeirinho"
		expect(page).to have_content "Mercedes"
		expect(page).to have_content "2017"
		expect(page).to have_content "Atego"
		expect(page).to have_content "AAAA000"
	end

	it "sem veículos cadastrados" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Veículos"

		expect(page).to have_content "Sem veículos registrados"
	end
end