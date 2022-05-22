require 'rails_helper'

RSpec.describe Admin, type: :model do
	describe "#valid" do
		it "falso se possuir campos vazios" do
			admin = Admin.create(email:"lucas@sistemadefrete.com",password:"password",name:"")

			result = admin.valid?

			expect(result).to eql false
		end

		it "falso se dominio de email diferente de @sistemadefrete" do
			admin = Admin.create(email:"lucas@banana.com",password:"password",name:"Lucas")

			result = admin.valid?

			expect(result).to eql false
		end

		it "email deve ser único" do
			admin = Admin.create(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
			second_admin = Admin.create(email:"lucas@sistemadefrete.com",password:"codigo",name:"Ana")

			result = second_admin.valid?

			expect(result).to eql false
		end
	end
end
