require 'rails_helper'

RSpec.describe TablePrice, type: :model do
	describe "#valid" do
		it "falso se o campo Peso mínimo estiver vazio" do
			tp = TablePrice.create(minimum_weight:"",max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:minimum_weight)

			expect(result).to be true
			expect(tp.errors[:minimum_weight]).to include("não pode ficar em branco")
		end

		it "falso se o campo Peso máximo estiver vazio" do
			tp = TablePrice.create(minimum_weight:10,max_weight:"",minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:max_weight)

			expect(result).to be true
			expect(tp.errors[:max_weight]).to include("não pode ficar em branco")
		end

		it "falso se o campo Altura mínima estiver vazio" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height: "",
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
				

			tp.valid?
			result = tp.errors.include?(:minimum_height)

			expect(result).to be true
			expect(tp.errors[:minimum_height]).to include("não pode ficar em branco")
		end

		it "falso se o campo Comprimento mínimo estiver vazio" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:"",max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			

			tp.valid?
			result = tp.errors.include?(:minimum_length)

			expect(result).to be true
			expect(tp.errors[:minimum_length]).to include("não pode ficar em branco")
		end
		
		it "falso se o campo Largura mínima estiver vazio" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:"",max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			

			tp.valid?
			result = tp.errors.include?(:minimum_width)

			expect(result).to be true
			expect(tp.errors[:minimum_width]).to include("não pode ficar em branco")
		end
		
		it "falso se o campo Altura máxima estiver vazio" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:"",minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
	

			tp.valid?
			result = tp.errors.include?(:max_height)

			expect(result).to be true
			expect(tp.errors[:max_height]).to include("não pode ficar em branco")
		end


		it "falso se o campo Comprimento máximo estiver vazio" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:"",price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			

			tp.valid?
			result = tp.errors.include?(:max_length)

			expect(result).to be true
			expect(tp.errors[:max_length]).to include("não pode ficar em branco")
		end

		it "falso se o campo Largura máxima estiver vazio" do
			tp =TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:"",
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			

			tp.valid?
			result = tp.errors.include?(:max_width)

			expect(result).to be true
			expect(tp.errors[:max_width]).to include("não pode ficar em branco")
		end


		it "falso se o campo Preço estiver vazio" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:"",shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:price)

			expect(result).to be true
			expect(tp.errors[:price]).to include("não pode ficar em branco")
		end


		it "falso se o campo Preço for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:price)

			expect(result).to be true
			expect(tp.errors[:price]).to include("deve ser maior que 0")
		end

		it "falso se o campo Peso mínimo for 0" do
			tp = TablePrice.create(minimum_weight:0,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:minimum_weight)

			expect(result).to be true
			expect(tp.errors[:minimum_weight]).to include("deve ser maior que 0")
		end

		it "falso se o campo Peso máximo for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:0,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:max_weight)

			expect(result).to be true
			expect(tp.errors[:max_weight]).to include("deve ser maior que 0")
		end

		it "falso se o campo Altura máxima for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:0,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:max_height)

			expect(result).to be true
			expect(tp.errors[:max_height]).to include("deve ser maior que 0")
		end

		it "falso se o campo Altura mínima for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:0,
											 max_height:20,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:minimum_height)

			expect(result).to be true
			expect(tp.errors[:minimum_height]).to include("deve ser maior que 0")
		end

		it "falso se o campo Largura mínima for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:0,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:minimum_width)

			expect(result).to be true
			expect(tp.errors[:minimum_width]).to include("deve ser maior que 0")
		end

		it "falso se o campo Largura máxima for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:0,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:max_width)

			expect(result).to be true
			expect(tp.errors[:max_width]).to include("deve ser maior que 0")
		end

		it "falso se o campo Comprimento máximo for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:0,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:max_length)

			expect(result).to be true
			expect(tp.errors[:max_length]).to include("deve ser maior que 0")
		end

		it "falso se o campo Comprimento mínimo for 0" do
			tp = TablePrice.create(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:0,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:minimum_length)

			expect(result).to be true
			expect(tp.errors[:minimum_length]).to include("deve ser maior que 0")
		end

		it "falso se o campo Peso mínimo maior que Peso máximo" do
			tp = TablePrice.create(minimum_weight:100,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:10,shipping_company_id:1,minimum_dimension:10,max_dimension:375)
			
			tp.valid?
			result = tp.errors.include?(:max_weight)

			expect(result).to be true
			expect(tp.errors[:max_weight]).to include("deve ser maior que 100")
		end
	end
end
