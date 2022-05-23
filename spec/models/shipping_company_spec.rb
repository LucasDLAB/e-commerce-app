require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do
	describe "#valid" do
		it "falso se o campo Razão Social não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = second_sc.valid?

			expect(result).to eql false
		end

		it "falso se o campo Nome Fantasia não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.create(brand_name: "Ligeirinho LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = second_sc.valid?

			expect(result).to eql false
		end

		it "falso se o campo Número de registro não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.create(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910110",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = second_sc.valid?

			expect(result).to eql false
		end

		it "falso se o campo Dominio de email não for único" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")
			second_sc = ShippingCompany.create(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = second_sc.valid?

			expect(result).to eql false
		end


		it "falso se o campo Razão Social estiver vazio" do
			sc = ShippingCompany.create(brand_name: "",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end

		it "falso se o campo Nome Fantasia estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end

		it "falso se o campo Número de registro estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end

		it "falso se o campo Dominio de email estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end

		it "falso se o campo Rua estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "", number: 152, state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end		

		it "falso se o campo Número estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number:"" , state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end	

		it "falso se o campo Estado estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end	

		it "falso se o campo Cidade estiver vazio" do
			sc = ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"")

			result = sc.valid?

			expect(result).to eql false
		end	
		
		it "falso se o numero de registro possuir menos de 14 caracteres" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"1234567891011",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end

		it "falso se o numero de registro possuir mais de 14 caracteres" do
			sc =ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"123456789101100",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo")

			result = sc.valid?

			expect(result).to eql false
		end
	end
end
