require "rails_helper"

describe "Colaborador da Transportadora acessa a página de transportadora" do

	it "com sucesso" do
		sc = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		click_on "Criar um usuário"
		within "form" do
			fill_in "Nome", with: "Lucas"
			fill_in "E-mail", with: "lucas@quick.com"
			fill_in "Senha", with: "password"
			fill_in "Confirme sua senha", with: "password"
			click_on "Registrar"
		end			
		click_on "Transportadora Quicksilver"
		
		expect(page).not_to have_content "Entrar"
		expect(page).to have_content "Transportadora Quicksilver"
		expect(page).to have_content "Quicksilver LTDA"
		expect(page).to have_content "12.345.678/9101-10"
		expect(sc.billing_address).to eql "Carlos Reis 152 - São Gonçalo, RJ"
	end
end
