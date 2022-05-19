require "rails_helper"

describe "Usuário acessa a página principal" do
	it "acessa a página como visitante" do
		visit root_path

		expect(page).to have_content("Stay Night")

		within("nav") do
			expect(page).to have_content("Entrar como Administrador")
			expect(page).to have_content("Entrar como colaborador de uma Transportadora")
			expect(page).to have_content("Rastrear um pedido")
		end
		
		within("p") do
			expect(page).to have_content("A Stay night é uma plataforma digital fundada com o objetivo de melhor atender sua demanda da melhor maneira e com preço acessível.")
		end
	end
end