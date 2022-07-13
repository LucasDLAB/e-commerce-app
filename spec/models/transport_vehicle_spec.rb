require 'rails_helper'

RSpec.describe TransportVehicle, type: :model do
	describe "#valid" do
		it "falso se os campos estiverem vazios" do 
			tv = TransportVehicle.create()
			
			tv.valid?
			result = tv.valid?

			expect(result).to be false
			expect(tv.errors[:brand]).to include("não pode ficar em branco")
			expect(tv.errors[:year_manufacture]).to include("não pode ficar em branco")
			expect(tv.errors[:payload]).to include("não pode ficar em branco")
			expect(tv.errors[:identification_plate]).to include("não pode ficar em branco")
			expect(tv.errors[:vehicle_model]).to include("não pode ficar em branco")
			expect(tv.errors[:height]).to include("não pode ficar em branco")
			expect(tv.errors[:length]).to include("não pode ficar em branco")
			expect(tv.errors[:width]).to include("não pode ficar em branco")
		end

		it "falso se o campo Ano de fabricação for futura" do 
			vehicle = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year+1,payload: 9000,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43)
			
			vehicle.valid?
			result = vehicle.errors.include?(:year_manufacture)

			expect(result).to be true
			expect(vehicle.errors[:year_manufacture]).to include("deve ser menor ou igual a #{Time.now.year}")
		end


		it "falso se o campo Capacidade máxima deve ser maior que 0" do 
			vehicle = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 0,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43)
			
			vehicle.valid?
			result = vehicle.errors.include?(:payload)

			expect(result).to be true
			expect(vehicle.errors[:payload]).to include("deve ser maior que 0")
		end

		it "falso se o campo Deve ter 4 letras e 3 números" do 
			vehicle = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 0,
												 identification_plate:"AAA0000",vehicle_model:"Atego",
												 height:12,length:33,width:43)
			
			vehicle.valid?
			result = vehicle.errors.include?(:identification_plate)

			expect(result).to be true
			expect(vehicle.errors[:identification_plate]).to include("deve possuir 4 letras e 3 números.")
		end

		it "falso se o campo Placa de identificação não for único" do 
			shipping_company = create(:shipping_company)
			vehicle = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 10,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id: shipping_company.id)
			second_vehicle = TransportVehicle.create(brand: "Mercedes",year_manufacture:Time.now.year,payload: 10,
												 identification_plate:"AAAA000",vehicle_model:"Atego",
												 height:12,length:33,width:43, shipping_company_id: shipping_company.id)

			second_vehicle.valid?
			result = second_vehicle.errors.include?(:identification_plate)

			expect(result).to be true
			expect(second_vehicle.errors[:identification_plate]).to include("já está em uso")
		end
	end
end
