require 'rails_helper'

RSpec.describe TransportVehicle, type: :model do
	describe "#valid" do
		it "falso se o campo Marca estiver vazio" do 
			ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
													registration_number:"12345678910110",email_domain: "@quick.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "",year_manufacture: 2017,payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:brand)

			expect(result).to be true
			expect(tv.errors[:brand]).to include("não pode ficar em branco")
		end

		it "falso se o campo Ano de fabricação estiver vazio" do 
			ShippingCompany.create(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
													registration_number:"12345678910110",email_domain: "@quick.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:"",payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:year_manufacture)

			expect(result).to be true
			expect(tv.errors[:year_manufacture]).to include("não pode ficar em branco")
		end

		it "falso se o campo Capacidade máxima estiver vazio" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
													registration_number:"12345678910110",email_domain: "@quick.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:2017,payload: "",
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:payload)

			expect(result).to be true
			expect(tv.errors[:payload]).to include("não pode ficar em branco")
		end

		it "falso se o campo Placa de identificação estiver vazio" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
													registration_number:"12345678910110",email_domain: "@quick.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:2017,payload: 9000,
												 identification_plate:"",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:identification_plate)

			expect(result).to be true
			expect(tv.errors[:identification_plate]).to include("não pode ficar em branco")
		end

		it "falso se o campo Modelo do veículo estiver vazio" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:2017,payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:vehicle_model)

			expect(result).to be true
			expect(tv.errors[:vehicle_model]).to include("não pode ficar em branco")
		end

		it "falso se o campo Altura estiver vazio" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:2017,payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:"",length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:height)

			expect(result).to be true
			expect(tv.errors[:height]).to include("não pode ficar em branco")
		end

		it "falso se o campo Comprimento estiver vazio" do 
				ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:2017,payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:"",width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:length)

			expect(result).to be true
			expect(tv.errors[:length]).to include("não pode ficar em branco")
		end

		it "falso se o campo Largura estiver vazio" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
														registration_number:"12345678910110",email_domain: "@quick.com",
														street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:"",payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:"", shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:width)

			expect(result).to be true
			expect(tv.errors[:width]).to include("não pode ficar em branco")
		end

		it "falso se o campo Ano de fabricação for futura" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
													registration_number:"12345678910110",email_domain: "@quick.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year+1,payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:year_manufacture)

			expect(result).to be true
			expect(tv.errors[:year_manufacture]).to include("deve ser menor ou igual a #{Time.now.year}")
		end

		it "falso se o campo Ano de fabricação for futura" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
													registration_number:"12345678910110",email_domain: "@quick.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year+1,payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:year_manufacture)

			expect(result).to be true
			expect(tv.errors[:year_manufacture]).to include("deve ser menor ou igual a #{Time.now.year}")
		end

		it "falso se o campo Capacidade máxima deve ser maior que 0" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
															registration_number:"12345678910110",email_domain: "@quick.com",
															street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 0,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:payload)

			expect(result).to be true
			expect(tv.errors[:payload]).to include("deve ser maior que 0")
		end

		it "falso se o campo Deve ter 4 letras e 3 números" do 
			sc = ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
													registration_number:"12345678910110",email_domain: "@quick.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 0,
												 identification_plate:"AAA0000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			
			tv.valid?
			result = tv.errors.include?(:identification_plate)

			expect(result).to be true
			expect(tv.errors[:identification_plate]).to include("deve possuir 4 letras e 3 números.")
		end

		it "falso se o campo Placa de identificação ter 4 letras e 3 números" do 
			ShippingCompany.create!(brand_name: "Quicksilver LTDA",corporate_name:"Quicksilver",
												registration_number:"12345678910110",email_domain: "@quick.com",
												street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
			tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 10,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)
			second_tv = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 10,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id:1)

			second_tv.valid?
			result = second_tv.errors.include?(:identification_plate)

			expect(result).to be true
			expect(second_tv.errors[:identification_plate]).to include("já está em uso")
		end
	end
end
