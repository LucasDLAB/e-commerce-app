# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
linha = "-=" * 10

p linha
p "Carregando Administrador"
	Admin.create!(email:"teste@sistemadefrete.com",password:"password",name:"Testing")
p linha 
p "Administrador pronto"

p linha
p "Carregando Transportadora"
	ShippingCompany.create!(brand_name: "Ligeirinho LTDA",corporate_name:"Ligeirinho",
													registration_number:"12345678910112",email_domain: "@ligeiro.com",
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:1)
p linha 
p "Transportadora pronta"

p linha
p "Carregando Usuário"
	User.create!(email:"teste@ligeiro.com",password:"password",name:"Testing")
p "Usuário pronto"
p linha 


#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
