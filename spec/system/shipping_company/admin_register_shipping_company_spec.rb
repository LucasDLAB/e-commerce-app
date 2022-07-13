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
		expect(page).to have_field "Distância em Km"
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
		fill_in "Nome Fantasia", with: "Ligeirinho"
		fill_in "Razão Social", with: "Ligeirinho LTDA"
		fill_in "Número de registro", with: '55307710191150'
		fill_in "Domínio de email", with: "@ligeiro.com"
		fill_in "Rua", with: "Rua Carlos Reis"
		fill_in "Número", with: 152
		fill_in "Cidade", with: "São Gonçalo"
		fill_in "Distância em Km", with:200
		fill_in "Estado", with: "RJ"
		click_on "Registrar Transportadora"

		expect(page).to have_content "Transportadora Ligeirinho"
		expect(page).to have_content "Ligeirinho LTDA"
		expect(page).to have_content '55.307.710/1911-50'
		expect(page).to have_content "Rua Carlos Reis 152 - São Gonçalo, RJ"
  end

  it "com dados inválidos" do
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
		fill_in "Nome Fantasia", with: ""
		click_on "Registrar Transportadora"

		expect(page).to have_content "Falha ao cadastrar a Transportadora"
    expect(page).to have_content "Razão Social não pode ficar em branco"
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
    expect(page).to have_content "Domínio de email não pode ficar em branco"
    expect(page).to have_content "Número de registro não pode ficar em branco"
    expect(page).to have_content "Distância em Km não pode ficar em branco"
    expect(page).to have_content "Distância em Km não é um número"
    expect(page).to have_content "Estado não pode ficar em branco"
    expect(page).to have_content "Rua não pode ficar em branco"
    expect(page).to have_content "Número não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Razão Social não pode ficar em branco"
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
    expect(page).to have_content "Domínio de email não pode ficar em branco"
    expect(page).to have_content "Número de registro não pode ficar em branco"
    expect(page).to have_content "Número de registro não é válido"
    expect(page).to have_content "Domínio de email não é válido"
	end

	it "retorna à página de transportadoras a partir da página registro de transportadora" do
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
		click_on "Voltar para a página de transportadoras"

		expect(page).to have_content "Transportadoras Filiadas"
	end
end