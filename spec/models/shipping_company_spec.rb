require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do
	describe "#valid" do
		it "falso se os campos não forem únicos" do
			sc = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			second_sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)

			second_sc.valid?
			result = second_sc.valid?

			expect(result).to be false
			expect(second_sc.errors[:brand_name]).to include("já está em uso")
			expect(second_sc.errors[:corporate_name]).to include("já está em uso")
			expect(second_sc.errors[:registration_number]).to include("já está em uso")
			expect(second_sc.errors[:email_domain]).to include("já está em uso")
		end


		it "falso se os campos estiverem vazios" do
			sc = ShippingCompany.create()

			sc.valid?
			result = sc.valid?

			expect(result).to be false
			expect(sc.errors[:brand_name]).to include("não pode ficar em branco")
			expect(sc.errors[:corporate_name]).to include("não pode ficar em branco")
			expect(sc.errors[:registration_number]).to include("não pode ficar em branco")
			expect(sc.errors[:email_domain]).to include("não pode ficar em branco")
			expect(sc.errors[:street]).to include("não pode ficar em branco")
			expect(sc.errors[:number]).to include("não pode ficar em branco")
			expect(sc.errors[:state]).to include("não pode ficar em branco")
			expect(sc.errors[:city]).to include("não pode ficar em branco")
			expect(sc.errors[:distance]).to include("não pode ficar em branco")
		end	
		
		it "falso se o numero de registro possuir menos de 14 caracteres" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"1234567891011",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:registration_number)

			expect(result).to be true
			expect(sc.errors[:registration_number]).to include("não possui o tamanho esperado (14 caracteres)")
		end

		it "falso se o numero de registro possuir mais de 14 caracteres" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"123456789101100",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:registration_number)

			expect(result).to be true
			expect(sc.errors[:registration_number]).to include("não possui o tamanho esperado (14 caracteres)")
		end

		it "falso se o campo Estado não for maiúscula" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"123456789101100",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"Rs", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:state)

			expect(result).to be true
			expect(sc.errors[:state]).to include("não é válido")
		end

		it "falso se o campo Estado possuir apenas uma letra" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"123456789101100",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"R", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:state)

			expect(result).to be true
			expect(sc.errors[:state]).to include("não é válido")
		end

		it "falso se o campo Estado possuir mais de duas letras" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"123456789101100",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RSS", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:state)

			expect(result).to be true
			expect(sc.errors[:state]).to include("não possui o tamanho esperado (2 caracteres)")
		end

		it "falso se o campo Dominio de email possuir formato diferente de @..." do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"123456789101100",email_domain: "quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:email_domain)

			expect(result).to be true
			expect(sc.errors[:email_domain]).to include("não é válido")
		end
	end
end
