require "rails_helper"

describe "Administrador registra uma nova Transportadora" do
	it "acessa o formulário de cadastro" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")

		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		click_on "Transportadoras"
		click_on "Cadastrar uma nova Transportadora"

		expect(page).to have_field "Nome Fantasia"
		expect(page).to have_field "Razão Social"
		expect(page).to have_field "Número de registro"
		expect(page).to have_field "Domínio de email"
		expect(page).to have_field "Rua"
		expect(page).to have_field "Número"
		expect(page).to have_field "Cidade"
		expect(page).to have_field "Estado"
				
	end

	it "com sucesso" do
		Admin.create!(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")

		visit root_path 
		click_on "Entrar como Administrador"
		fill_in "E-mail", with:"lucas@sistemadefrete.com"
		fill_in "Senha", with: "password"
		within "form" do
			click_on "Entrar"
		end
		
		click_on "Transportadoras"
		click_on "Cadastrar uma nova Transportadora"
		fill_in "Nome Fantasia", with: "Quicksilver"
		fill_in "Razão Social", with: "Quicksilver LTDA"
		fill_in "Número de registro", with: "12345678910110"
		fill_in "Domínio de email", with: "quick.com"
		fill_in "Rua", with: "Carlos Reis"
		fill_in "Número", with: 152
		fill_in "Cidade", with: "São Gonçalo"
		fill_in "Estado", with: "RJ"
		click_on "Registrar Transportadora"

		expect(page).to have_content "Transportadora Quicksilver"
		expect(page).to have_content "Quicksilver LTDA"
		expect(page).to have_content "12.345.678/9101-10"
		expect(page).to have_content "Rua Carlos Reis 152 - São Gonçalo, RJ"
  end

  it "com dados inválidos" do

	end
end