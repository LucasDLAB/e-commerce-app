require "rails_helper"

describe "Usuário da Transportadora cadastra uma nova linha na tabela de preço" do
	it "acessa a página do formulário" do
		visit new_table_price

		expect(page).to have_field "Peso mínimo"
		expect(page).to have_field "Peso máximo"
		expect(page).to have_field "Altura máxima"
		expect(page).to have_field "Altura mínima"
		expect(page).to have_field "Largura máxima"
		expect(page).to have_field "Largura mínima"
		expect(page).to have_field "Comprimento máximo"
		expect(page).to have_field "Comprimento mínimo"		
	end

	it "com sucesso" do
	end

	it "com dados vazios" do
	end
end