require 'rails_helper'

RSpec.describe Order, type: :model do
	describe "#valid" do
		it "falso se os campos estiverem vazios" do
			order = Order.new(destinatary_name:"")
			 
			order.valid?

			expect(order.errors[:destinatary_name]).to include("não pode ficar em branco")
			expect(order.errors[:destinatary_identification]).to include("não pode ficar em branco")
			expect(order.errors[:street]).to include("não pode ficar em branco")
			expect(order.errors[:state]).to include("não pode ficar em branco")
			expect(order.errors[:weight]).to include("não pode ficar em branco")
			expect(order.errors[:width]).to include("não pode ficar em branco")
			expect(order.errors[:length]).to include("não pode ficar em branco")
			expect(order.errors[:number]).to include("não pode ficar em branco")
			expect(order.errors[:destinatary_distance]).to include("não pode ficar em branco")
			expect(order.errors[:height]).to include("não pode ficar em branco")
			expect(order.errors[:city]).to include("não pode ficar em branco")
		end

		it "falso se os campos [Peso,Largura,Comprimento,Altura,Número,Distância do destinatário]" do
			order = Order.new(weight:"a",width:"a",height:"a",length:"a",number:"a",
												destinatary_distance:"a",height:"a")
			 
			order.valid?

			expect(order.errors[:weight]).to include("não é um número")
			expect(order.errors[:width]).to include("não é um número")
			expect(order.errors[:length]).to include("não é um número")
			expect(order.errors[:number]).to include("não é um número")
			expect(order.errors[:destinatary_distance]).to include("não é um número")
			expect(order.errors[:height]).to include("não é um número")
		end

		it "falso se o campo Estado possuir mais de duas letras" do
			order = Order.create(state:"RSS")

			order.valid?
			result = order.errors.include?(:state)

			expect(result).to be true
			expect(order.errors[:state]).to include("não possui o tamanho esperado (2 caracteres)")
		end

		it "falso se o campo Estado possuir apenas uma letra" do
			order = Order.create(state:"R")

			order.valid?
			result = order.errors.include?(:state)

			expect(result).to be true
			expect(order.errors[:state]).to include("não é válido")
		end
	end
end
