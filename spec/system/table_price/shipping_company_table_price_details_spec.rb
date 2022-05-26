require "rails_helper"

describe "Usuário acessa a Tabela de Preços" do
	it "sem linhas adicionadas" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo", distance:1)
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Tabela de Preços"

		expect(page).to have_content "Tabela de Preços da Transportadora Ligeirinho"
		expect(page).to have_content "Tabela não possui linhas de preço"
	end

	it "com linhas de preço" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo", distance:1)
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Tabela de Preços"

		expect(page).to have_content "De 10 a 50"
		expect(page).to have_content "De 10 a 375"
		expect(page).to have_content "R$ 0,5"
	end

	it "retorna à página da Transportadora" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Tabela de Preços"
		click_on "Voltar"

		expect(page).to have_content "Transportadora Ligeirinho"
	end
end
