require "rails_helper"

describe "Administrador acessa a página de transportadoras" do
	it "com sucesso" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

		visit root_path
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Transportadoras"

		expect(page).to have_content "Transportadoras Filiadas"
		expect(page).to have_content "Quicksilver"
		expect(page).to have_content "12.345.678/9101-10"
	end

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

	it "criar conta de Administrador" do
		ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

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
		expect(page).to have_content "Quicksilver"
		expect(page).to have_content "12.345.678/9101-10"
	end
end