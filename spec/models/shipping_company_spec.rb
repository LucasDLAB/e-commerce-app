require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do
	describe "#valid" do
		it "falso se o campo Razão Social não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.new(brand_name: "Quicksilver LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			second_sc.valid?
			result = second_sc.errors.include?(:brand_name)

			expect(result).to be true
			expect(second_sc.errors[:brand_name]).to include("já está em uso")
		end

		it "falso se o campo Nome Fantasia não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.create(brand_name: "Ligeirinho LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			second_sc.valid?
			result = second_sc.errors.include?(:corporate_name)

			expect(result).to be true
			expect(second_sc.errors[:corporate_name]).to include("já está em uso")
		end

		it "falso se o campo Número de registro não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.create(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910110",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			second_sc.valid?
			result = second_sc.errors.include?(:registration_number)

			expect(result).to be true
			expect(second_sc.errors[:registration_number]).to include("já está em uso")
		end

		it "falso se o campo Dominio de email não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.create(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = second_sc.valid?
			result = second_sc.errors.include?(:email_domain)

			expect(result).to be true
			expect(second_sc.errors[:email_domain]).to include("já está em uso")
		end


		it "falso se o campo Razão Social estiver vazio" do
			sc = ShippingCompany.create(brand_name: "",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:brand_name)

			expect(result).to be true
			expect(sc.errors[:brand_name]).to include("não pode ficar em branco")
		end

		it "falso se o campo Nome Fantasia estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:corporate_name)

			expect(result).to be true
			expect(sc.errors[:corporate_name]).to include("não pode ficar em branco")
		end

		it "falso se o campo Número de registro estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:registration_number)

			expect(result).to be true
			expect(sc.errors[:registration_number]).to include("não pode ficar em branco")
		end

		it "falso se o campo Dominio de email estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:email_domain)

			expect(result).to be true
			expect(sc.errors[:email_domain]).to include("não pode ficar em branco")
		end

		it "falso se o campo Rua estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "", number: 152, state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:street)

			expect(result).to be true
			expect(sc.errors[:street]).to include("não pode ficar em branco")
		end		

		it "falso se o campo Número estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number:"" , state:"RJ", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:number)

			expect(result).to be true
			expect(sc.errors[:number]).to include("não pode ficar em branco")
		end	

		it "falso se o campo Estado estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:state)

			expect(result).to be true
			expect(sc.errors[:state]).to include("não pode ficar em branco")
		end	

		it "falso se o campo Cidade estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"")

			sc.valid?
			result = sc.errors.include?(:city)

			expect(result).to be true
			expect(sc.errors[:city]).to include("não pode ficar em branco")
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

		it "falso se o campo Estado possuir formato diferente de [A-Z]{2}" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"123456789101100",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"Rs", city:"São Gonçalo")

			sc.valid?
			result = sc.errors.include?(:state)

			expect(result).to be true
			expect(sc.errors[:state]).to include("não é válido")
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
