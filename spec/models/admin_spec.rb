require 'rails_helper'

RSpec.describe Admin, type: :model do
	describe "#valid" do
		it "falso se possuir campos vazios" do
			admin = Admin.new(email:"lucas@sistemadefrete.com",password:"password",name:"")

			admin.valid?
			result = admin.errors.include?(:name)

			expect(result).to be true
			expect(admin.errors[:name]).to include("não pode ficar em branco")
		end

		it "falso se dominio de email diferente de @sistemadefrete" do
			admin = Admin.new(email:"lucas@banana.com",password:"password",name:"Lucas")

			admin.valid?
			result = admin.errors.include?(:email)

			expect(result).to be true
			expect(admin.errors[:email]).to include("não é válido")
		end

		it "email deve ser único" do
			admin = Admin.create(email:"lucas@sistemadefrete.com",password:"password",name:"Lucas")
			second_admin = Admin.new(email:"lucas@sistemadefrete.com",password:"codigo",name:"Ana")

			second_admin.valid?
			result = second_admin.errors.include?(:email)

			expect(result).to be true
			expect(second_admin.errors[:email]).to include("já está em uso")
		end

		it "nome deve começar com letras maiúsculas" do
			admin = Admin.create(email:"lucas@sistemadefrete.com",password:"password",name:"lucas")

			admin.valid?
			result = admin.errors.include?(:name)

			expect(result).to be true
			expect(admin.errors[:name]).to include("não é válido")
		end
	end
end
