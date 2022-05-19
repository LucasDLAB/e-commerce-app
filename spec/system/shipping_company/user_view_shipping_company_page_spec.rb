require "rails_helper"

describe "Colaborador acessa a página de transportadora" do
=begin
	it "com sucesso" do
		ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",registration_number:"12345678910110",email_domain: "quick.com")

		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"

		expect(page).to have_content "Transportadoras filiadas"
		expect(page).to have_content "Quicksilver"
		expect(page).to have_content "Quicksilver LTDA"
		expect(page).to have_content "123.456.789/1011-0"
	end

	it "sem a transportadora cadastrada" do
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
	end
=end
end
