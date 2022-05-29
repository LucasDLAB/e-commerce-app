require "rails_helper"

describe "Administrador cria um orçamento" do 
	it "acessa o formulário" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")

		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Fazer um novo orçamento"

		expect(page).to have_content "Criando um orçamento"
		expect(page).to have_field "Distância em Km"
		expect(page).to have_field "Altura em cm"
		expect(page).to have_field "Largura em cm"
		expect(page).to have_field "Comprimento em cm"
		expect(page).to have_field "Peso em Kg"
		expect(page).to have_button "Confirmar parâmetros"
	end

	it "com sucesso" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo", distance:1)
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1)
		EstimatedDate.create!(min_distance:10 , max_distance:100, business_day: 3,shipping_company_id:1)

		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Fazer um novo orçamento"
		fill_in "Distância em Km", with:50
		fill_in "Altura em cm", with:3
		fill_in "Largura em cm", with:3
		fill_in "Comprimento em cm", with:3
		fill_in "Peso em Kg", with:25
		click_on "Confirmar parâmetros"

		expect(page).to have_content "Resultado do orçamento"
		expect(page).to have_content "3 dia(s) úteis"
		expect(page).to have_content "R$ 25,00"
	end

	it "deve apresentar apenas o maior valor de uma Transportadora" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo", distance:1)
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:5,
											 max_height:10,minimum_width:10,max_width:50,
											 minimum_length:10,max_length:15,price:1.5,shipping_company_id:1)
		
		TablePrice.create!(minimum_weight:1,max_weight:20,minimum_height:1,
											 max_height:4,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.2,shipping_company_id:1)
		EstimatedDate.create!(min_distance:101 , max_distance:200, business_day: 5,shipping_company_id:1)
		EstimatedDate.create!(min_distance:10 , max_distance:100, business_day: 3,shipping_company_id:1)

		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Fazer um novo orçamento"
		fill_in "Distância em Km", with:50
		fill_in "Altura em cm", with:3
		fill_in "Largura em cm", with:3
		fill_in "Comprimento em cm", with:3
		fill_in "Peso em Kg", with:25
		click_on "Confirmar parâmetros"

		expect(page).to have_content "Resultado do orçamento"
		expect(page).not_to have_content "R$ 10,00"
		expect(page).to have_content "R$ 75,00"
	end

	it "deve apresentar o maior valor de cada Transportadora" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo", distance:1)
		ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:5,
											 max_height:10,minimum_width:10,max_width:50,
											 minimum_length:10,max_length:15,price:1.5,shipping_company_id:1)
		
		TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:5,
											 max_height:10,minimum_width:10,max_width:50,
											 minimum_length:10,max_length:15,price:2,shipping_company_id:2)
		EstimatedDate.create!(min_distance:10 , max_distance:200, business_day: 5,shipping_company_id:1)
		EstimatedDate.create!(min_distance:10 , max_distance:100, business_day: 3,shipping_company_id:2)

		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Fazer um novo orçamento"
		fill_in "Distância em Km", with:50
		fill_in "Altura em cm", with:3
		fill_in "Largura em cm", with:3
		fill_in "Comprimento em cm", with:3
		fill_in "Peso em Kg", with:25
		click_on "Confirmar parâmetros"

		expect(page).to have_content "Resultado do orçamento"
		expect(page).to have_content "R$ 100,00"
		expect(page).to have_content "R$ 75,00"
	end
end


