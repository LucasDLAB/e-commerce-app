require 'rails_helper'

RSpec.describe TablePrice, type: :model do
	describe "#valid" do
		it "falso se os campos estiverem vazios" do
			tp = TablePrice.create()

			expect(tp.errors[:minimum_weight]).to include("não pode ficar em branco")
			expect(tp.errors[:max_weight]).to include("não pode ficar em branco")
			expect(tp.errors[:minimum_height]).to include("não pode ficar em branco")
			expect(tp.errors[:minimum_length]).to include("não pode ficar em branco")
			expect(tp.errors[:minimum_width]).to include("não pode ficar em branco")
			expect(tp.errors[:max_height]).to include("não pode ficar em branco")
			expect(tp.errors[:max_length]).to include("não pode ficar em branco")
			expect(tp.errors[:max_width]).to include("não pode ficar em branco")
			expect(tp.errors[:price]).to include("não pode ficar em branco")
		end


		it "falso se os campos forem 0" do
			tp = TablePrice.create(minimum_weight:0,max_weight:0,minimum_height:0,
											 max_height:0,minimum_width:0,max_width:0,
											 minimum_length:0,max_length:0,price:0,shipping_company_id:1)
			
			tp.valid?

			expect(tp.errors[:price]).to include("deve ser maior que 0")
			expect(tp.errors[:minimum_weight]).to include("deve ser maior que 0")
			expect(tp.errors[:max_weight]).to include("deve ser maior que 0")
			expect(tp.errors[:max_height]).to include("deve ser maior que 0")
			expect(tp.errors[:minimum_height]).to include("deve ser maior que 0")
			expect(tp.errors[:minimum_width]).to include("deve ser maior que 0")
			expect(tp.errors[:max_width]).to include("deve ser maior que 0")
			expect(tp.errors[:max_length]).to include("deve ser maior que 0")
			expect(tp.errors[:minimum_length]).to include("deve ser maior que 0")
		end

		it "falso se o campo Peso mínimo maior que Peso máximo" do
			tp = TablePrice.create(minimum_weight:100,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1)
			
			tp.valid?
			result = tp.errors.include?(:max_weight)

			expect(result).to be true
			expect(tp.errors[:max_weight]).to include("deve ser maior que 100")
		end

		it "falso se o campo Peso mínimo igual ao Peso máximo" do
			tp = TablePrice.create(minimum_weight:100,max_weight:100,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1)
			
			tp.valid?
			result = tp.errors.include?(:max_weight)

			expect(result).to be true
			expect(tp.errors[:max_weight]).to include("deve ser maior que 100")
		end

		it "verdadeiro se o campo Dimensão máxima e Dimensão mínima for igual em Tabelas de diferentes transportadoras" do 	
			c = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			s = ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
														registration_number:"12345678910112",email_domain: "@ligeiro.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo", distance:1)
			tp = TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:c.id)
			second_tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:s.id)
			result = second_tp.valid? 
			
			expect(result).to be true
		end


		it "Dimensão mínima deve estar fora de intervalos cadastrados" do 	
			c = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tp = TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:c.id,minimum_dimension:10,max_dimension:375)
			second_tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:11,max_length:15,price:10,shipping_company_id:c.id,minimum_dimension:11,max_dimension:400)
			result = second_tp.valid? 
			
			expect(second_tp.errors[:minimum_dimension]).to include("deve possuir valor maior ou inferior ao dos intervalos anteriores")
		end

		it "Dimensão máxima deve estar fora de intervalos cadastrados" do 	
			c = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tp = TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:c.id)
			second_tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:14,price:10,shipping_company_id:c.id)
			result = second_tp.valid? 
			
			expect(second_tp.errors[:max_dimension]).to include("deve possuir valor maior ou inferior ao dos intervalos anteriores")
		end

		it "falso se possuir intervalos dentro de outros intervalos" do 	
			c = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tp = TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:c.id,minimum_dimension:10,max_dimension:375)
			second_tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:9,max_length:15,price:10,shipping_company_id:c.id,minimum_dimension:9,max_dimension:376)
			result = second_tp.valid? 
			
			expect(second_tp.errors[:minimum_dimension]).to include("não pode possuir intervalos que abrangem outros intervalos")
		end

		it "falso Dimensão máxima possuir parâmetros dentro de outros intervalos" do 	
			c = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tp = TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:c.id)
			second_tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:9,max_length:14,price:10,shipping_company_id:c.id)
			result = second_tp.valid? 
			
			expect(second_tp.errors[:max_dimension]).to include("não pode possuir intervalos que abrangem outros intervalos")
		end
	end
end
