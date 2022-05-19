require "rails_helper"

describe "Administrador acessa a página de transportadoras" do
	it "com sucesso" do
		ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",registration_number:"12345678910110",email_domain: "quick.com",billing_address:"Carlos Reis, 152 RJ")

		visit root_path
		click_on "Entrar como Administrador"

		expect(page).to have_content "Transportadoras Filiadas"
		expect(page).to have_content "Quicksilver"
		expect(page).to have_content "12.345.678/9101-10"
	end

	it "sem transportadoras cadastradas" do
		visit root_path
		click_on "Entrar como Administrador"

		expect(page).to have_content "Transportadoras Filiadas"
		expect(page).to have_content "Nenhuma transportadora cadastrada"
	end 
end