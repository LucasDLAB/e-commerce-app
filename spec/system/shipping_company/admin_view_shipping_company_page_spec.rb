require "rails_helper"

describe "Administrador acessa a página de transportadoras" do
	it "com sucesso" do
		ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",registration_number:"123.456.789/1011-0",email_domain: "quick.com")

		visit root_path
		click_on "Entrar como Administrador"

		expect(page).to have_content "Transportadoras Filiadas"
		expect(page).to have_content "Quicksilver"
		expect(page).to have_content "123.456.789/1011-0"
	end

	it "sem transportadoras cadastradas" do
		visit root_path
		click_on "Entrar como Administrador"

		expect(page).to have_content "Transportadoras Filiadas"
		expect(page).to have_content "Nenhuma transportadora cadastrada"
	end 
end