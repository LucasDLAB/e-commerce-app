require "rails_helper"

describe "Usuário da Transportadora cadastrada um novo veículo" do	
	it "acessa a página do formulário" do
		create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Adicionar um novo veículo"

		expect(page).to have_field "Marca do Veículo"
		expect(page).to have_field "Ano de fabricação"
		expect(page).to have_field "Modelo do Veículo"
		expect(page).to have_field "Placa de identificação"
		expect(page).to have_field "Capacidade máxima"
		expect(page).to have_field "Altura em cm"
		expect(page).to have_field "Largura em cm"
		expect(page).to have_field "Comprimento em cm"
	end

	it "com sucesso" do
		create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Adicionar um novo veículo"
		fill_in "Marca do Veículo", with: "Mercedes"
		fill_in "Ano de fabricação", with: "2017"
		fill_in "Modelo do Veículo", with:"Atego"
		fill_in "Placa de identificação", with:"AAAA000"
		fill_in "Capacidade máxima", with:9000_000
		fill_in "Altura em cm", with:12
		fill_in "Largura em cm", with:1
		fill_in "Comprimento em cm", with:5
		click_on "Registrar veículo"

		expect(page).to have_content "Veículo cadastrado com sucesso!"
		expect(page).to have_content "Mercedes"
		expect(page).to have_content "2017"	
	end

	it "com dados vazios" do
		create(:shipping_company, corporate_name: 'Ligeirinho', email_domain: '@ligeiro.com')
		User.create!(name:"Walter",email:"walter@ligeiro.com",password:"password")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Transportadora Ligeirinho"
		click_on "Adicionar um novo veículo"
		fill_in "Marca do Veículo", with: ""
		click_on "Registrar veículo"

		expect(page).to have_content "Falha ao cadastrar o veículo"
		expect(page).to have_content "Marca do Veículo não pode ficar em branco"
 		expect(page).to have_content "Ano de fabricação não pode ficar em branco"
 		expect(page).to have_content "Capacidade máxima em Kg não pode ficar em branco"
 		expect(page).to have_content "Modelo do Veículo não pode ficar em branco"
 		expect(page).to have_content "Altura em cm não pode ficar em branco"
 		expect(page).to have_content "Comprimento em cm não pode ficar em branco"
 		expect(page).to have_content "Largura em cm não pode ficar em branco"
 		expect(page).to have_content "Ano de fabricação não pode ficar em branco"
 		expect(page).to have_content "Placa de identificação não é válido"
 		expect(page).to have_content "Placa de identificação deve possuir 4 letras e 3 números."
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
		click_on "Adicionar um novo veículo"
		click_on "Voltar para a página da transportadora"

		expect(page).to have_content "Transportadora Ligeirinho"
	end
end