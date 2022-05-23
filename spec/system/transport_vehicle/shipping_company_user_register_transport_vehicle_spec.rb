require "rails_helper"

describe "Usuário da Transportadora cadastrada um novo veículo" do
	it "acessa a página do formulário" do
		visit new_transport_vehicle_path

		expect(page).to have_field "Marca"
		expect(page).to have_field "Ano de fabricação"
		expect(page).to have_field "Modelo de fabricação"
		expect(page).to have_field "Placa de identificação"
		expect(page).to have_field "Capacidade máxima"
		expect(page).to have_field "Altura"
		expect(page).to have_field "Largura"
		expect(page).to have_field "Comprimento"
	end

	it "com sucesso" do
		visit new_transport_vehicle_path
		fill_in "Marca", with: ""
		fill_in "Ano de fabricação", with: ""
		fill_in "Modelo de fabricação", with:""
		fill_in "Placa de identificação", with:""
		fill_in "Capacidade máxima", with:""
		fill_in "Altura", with:""
		fill_in "Largura", with:""
		fill_in "Comprimento", with:""
		click_on "Registrar"

		expect(page).to have_content ""
		expect(page).to have_content ""
		expect(page).to have_content ""
		expect(page).to have_content ""
		expect(page).to have_content ""
		expect(page).to have_content ""
	end

	it "com dados vazios" do
		visit new_transport_vehicle_path

		fill_in "Marca", with: ""

		expect(page).to have_content ""
	end
end