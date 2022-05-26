require "rails_helper"

describe "Usuário da Transportadora cadastra uma nova linha na tabela de preço" do
	it "acessa a página do formulário" do
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
		click_on "Adicionar linha na tabela de preço"

		expect(page).to have_field "Peso mínimo"
		expect(page).to have_field "Peso máximo"
		expect(page).to have_field "Altura máxima"
		expect(page).to have_field "Altura mínima"
		expect(page).to have_field "Largura máxima"
		expect(page).to have_field "Largura mínima"
		expect(page).to have_field "Comprimento máximo"
		expect(page).to have_field "Comprimento mínimo"
		expect(page).to have_field "Preço por Km"		
	end

	it "com sucesso" do
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
		click_on "Adicionar linha na tabela de preço"
		fill_in "Peso mínimo",with: 10
		fill_in "Peso máximo",with: 50
		fill_in "Altura mínima", with: 1 
		fill_in "Altura máxima", with: 5
		fill_in "Largura mínima", with: 1
		fill_in "Largura máxima", with: 5
		fill_in "Comprimento mínimo", with: 10
		fill_in "Comprimento máximo", with: 15
		fill_in "Preço por Km", with: 0.5
		click_on "Adicionar linha"

		expect(page).to have_content "Nova linha adicionada com sucesso!"
	end

	it "com dados vazios" do
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
		click_on "Adicionar linha na tabela de preço"
		fill_in "Peso mínimo",with: ""
		click_on "Adicionar linha"

		expect(page).to have_content "Falha ao adicionar a nova linha"
	end
end