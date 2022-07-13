require "rails_helper"

describe "Usuário acessa a Tabela de Preços" do
	it "sem linhas adicionadas" do
		create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Tabela de Preços"

		expect(page).to have_content "Tabela de Preços da Transportadora Ligeirinho"
		expect(page).to have_content "Tabela de Preços não possui linhas de preço"
	end

	it "com linhas de preço" do
		shipping_company = create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id: shipping_company.id)
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Tabela de Preços"

		expect(page).to have_content "De 10.0 a 50.0"
		expect(page).to have_content "De 0.00001 a 0.000375"
		expect(page).to have_content "R$ 0,50"
	end

	it "retorna à página da Transportadora" do
		create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Tabela de Preços"
		click_on "Voltar para a página da transportadora"

		expect(page).to have_content "Transportadora Ligeirinho"
	end
end
