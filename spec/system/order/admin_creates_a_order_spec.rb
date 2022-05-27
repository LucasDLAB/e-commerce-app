require "rails_helper"

describe "Administrador cria um novo pedido" do 
	it "acessa o formulário do pedido" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:100)
		
		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with: "lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Pedidos"
		click_on "Criar um novo pedido"

		expect(page).to have_content "Solicitação de novo pedido"
		expect(page).to have_field "Nome do destinatário"
		expect(page).to have_field "Número de identificação do destinatário"
		expect(page).to have_field "Rua"
		expect(page).to have_field "Cidade"
		expect(page).to have_field "Número"
		expect(page).to have_field "Estado"
		expect(page).to have_field "Peso"
		expect(page).to have_field "Largura"
		expect(page).to have_field "Comprimento"
		expect(page).to have_field "Altura"
		expect(page).to have_field "Distância do destinatário"
		expect(page).to have_button "Criar pedido"
	end 

	it "com sucesso" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:100)
		
		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with: "lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Pedidos"
		click_on "Criar um novo pedido"
		allow(SecureRandom).to receive(:alphanumeric).and_return("ABCDEF123456789")
		fill_in "Nome do destinatário", with:"João"
		fill_in "Número de identificação do destinatário", with: "00000000000"
		fill_in "Rua", with: "Rua Santa Teresa"
		fill_in "Cidade", with: "Rio de janeiro"
		fill_in "Número", with: 24
		fill_in "Estado", with: "RJ"
		fill_in "Peso", with: 27 
		fill_in "Largura", with: 12
		fill_in "Comprimento", with:15
		fill_in "Altura", with:32
		fill_in "Distância do destinatário", with: 5000
		click_on "Criar pedido"

		expect(page).to have_content "Pedido feito com sucesso" 
		expect(page).to have_content "Pedido ABCDEF123456789"
		expect(page).to have_content "Nome do destinatário"
		expect(page).to have_content "João"
		expect(page).to have_content "Distância do destinatário"
		expect(page).to have_content "5000"
		expect(page).to have_content "Peso"
		expect(page).to have_content "27"
		expect(page).to have_content "Dimensão"
		expect(page).to have_content "5760"
		expect(page).to have_content "Status do pedido"
		expect(page).to have_content "Pendente de aceite"
	end

	it "com campos vazios" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
		ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:100)
		
		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with: "lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		click_on "Entrar"
		click_on "Pedidos"
		click_on "Criar um novo pedido"
		fill_in "Nome do destinatário", with:""
		click_on "Criar pedido"

		expect(page).to have_content "Falha ao cadastrar ao criar o novo pedido" 
		expect(page).to have_content "Nome do destinatário não pode ficar em branco"
 		expect(page).to have_content "Número de identificação do destinatário não pode ficar em branco"
 		expect(page).to have_content "Rua não pode ficar em branco"
 		expect(page).to have_content "Cidade não pode ficar em branco"
 		expect(page).to have_content "Estado não pode ficar em branco"
 		expect(page).to have_content "Número não pode ficar em branco"
 		expect(page).to have_content "Peso não pode ficar em branco"
 		expect(page).to have_content "Largura não pode ficar em branco"
 		expect(page).to have_content "Comprimento não pode ficar em branco"
 		expect(page).to have_content "Altura não pode ficar em branco"
 		expect(page).to have_content "Distância do destinatário não pode ficar em branco"
 		expect(page).to have_content "Número não é um número"
 		expect(page).to have_content "Peso não é um número"
 		expect(page).to have_content "Largura não é um número"
 		expect(page).to have_content "Comprimento não é um número"
 		expect(page).to have_content "Altura não é um número"
 		expect(page).to have_content "Distância do destinatário não é um número"
	end
end

