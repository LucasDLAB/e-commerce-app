require "rails_helper"

describe "Colaborador da Transportadora acessa a página de transportadora" do

	it "com sucesso" do
		sc = ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		click_on "Criar um usuário"
		within "form" do
			fill_in "Nome", with: "Lucas"
			fill_in "E-mail", with: "lucas@ligeiro.com"
			fill_in "Senha", with: "password"
			fill_in "Confirme sua senha", with: "password"
			click_on "Registrar"
		end			
		click_on "Transportadora Ligeirinho"
		
		expect(page).not_to have_content "Entrar"
		expect(page).to have_content "Transportadora Ligeirinho"
		expect(page).to have_content "Razão Social"
		expect(page).to have_content "Ligeirinho LTDA"
		expect(page).to have_content "Número de registro"
		expect(page).to have_content "12.345.678/9101-12"
		expect(page).to have_content "Endereço de faturamento"
		expect(sc.billing_address).to eql "Carlos Reis 152 - São Gonçalo, RJ"
		expect(page).to have_content "Distância em Km"
		expect(page).to have_content "1.0 Km"
	end

	it "criar conta de colaborador de uma Transportadora" do
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", 
														city:"São Gonçalo",distance:1)

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		click_on "Criar um usuário"
		fill_in "Nome", with: "Walter"
		fill_in "E-mail", with: "walter@ligeiro.com"
		fill_in "Senha", with: "senhadowalter"
		fill_in "Confirme sua senha", with: "senhadowalter"
		click_on "Registrar"

		expect(page).to have_content "Transportadora Ligeirinho"
	end
end
