require "rails_helper"

describe "Colaborador da Transportadora acessa a página de transportadora" do

	it "com sucesso" do
=begin
	
rescue StandardError => e
	
end
		corporation = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
																					registration_number:"12345678910110",email_domain: "@quick.com",
																					street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
		User.create!(email:"lucas@quicksilver.com",password:"password",name:"Lucas",shipping_company_id: corporation.id)
		visit root_path
		click_on "Entrar como colaborador de uma Transportadora"
		within "form" do
			fill_in "E-mail", with: "lucas@quicksilver.com"
			fill_in "Senha", with: "password"
			click_on "Entrar"
		end			
		click_on "Transportadora"

		expect(page).not_to have_content "Entrar"
		expect(page).to have_content "Transportadora Quicksilver"
		expect(page).to have_content "Quicksilver LTDA"
		expect(page).to have_content "12.345.678/9101-10"
		expect(page).to have_content "Carlos Reis, 152 RJ"
=end
	end
end