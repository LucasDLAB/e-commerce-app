require "rails_helper"

describe "Administrador acessa a página de transportadoras" do

	it "sem transportadoras cadastradas" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")

		visit root_path
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Transportadoras"

		expect(page).to have_content "Transportadoras Filiadas"
		expect(page).to have_content "Nenhuma transportadora cadastrada"
	end 

	it "com sucesso" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)

		visit root_path
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Transportadoras"

		expect(page).to have_content "Transportadoras Filiadas"
		expect(page).to have_content "Ligeirinho"
		expect(page).to have_content "12.345.678/9101-12"
	end

	it "criar conta de Administrador" do
		visit root_path
		click_on "Entrar como Administrador"
		click_on "Criar um administrador"
		fill_in "Nome", with: "Ana"
		fill_in "E-mail", with: "ana@sistemadefrete.com"
		fill_in "Senha", with: "senhadaana"
		fill_in "Confirme sua senha", with: "senhadaana"
		click_on "Registrar"
		click_on "Transportadoras"

		expect(page).to have_content "Transportadoras Filiadas"
	end

	it "desativa a transportadora" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)

		visit root_path
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Transportadoras"
		click_on "Ligeirinho"
		click_on "Desativar transportadora"

		expect(page).to have_content "Status da Transportadora"
		expect(page).to have_content "Desativada"
	end

	it "ativa a transportadora" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1,status:2)

		visit root_path
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Transportadoras"
		click_on "Ligeirinho"
		click_on "Ativar transportadora"

		expect(page).to have_content "Status da Transportadora"
		expect(page).to have_content "Ativa"
	end
end