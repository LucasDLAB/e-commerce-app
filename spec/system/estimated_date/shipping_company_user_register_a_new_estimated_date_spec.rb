require "rails_helper"

describe "Usuário da Transportadora registra uma nova estimativa de entrega" do
	it "acessa o formulário de estimativa de entrega" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Adicionar uma nova linha de estimativa de entrega"
		
		expect(page).to have_field "Distância mínima"
		expect(page).to have_field "Distância máxima"
		expect(page).to have_field "Dia(s) úteis"
		expect(page).to have_button "Criar linha de estimativa"	
	end

	it "com sucesso" do

	end

	it "com campos vazios" do 
	end
end