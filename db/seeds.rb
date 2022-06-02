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
													street: "Carlos Reis", number: 152, state:"RJ", city:"São Gonçalo",distance:50)
p linha 
p "Transportadora pronta"

p linha
p "Carregando Usuário"
	User.create!(email:"teste@ligeiro.com",password:"password",name:"Testing")
p linha 
p "Usuário pronto"

p linha
p "Carregando Veículo"
	TransportVehicle.create!(brand: "Mercedes",year_manufacture: 2017,payload: 9000,
											 identification_plate:"AAAA000",vehicle_model:"Atego",
											 height:12,length:33,width:43, shipping_company_id:1)
p linha 
p "Veículo pronto"

p linha
p "Carregando Linha de preço"
	TablePrice.create!(minimum_weight:10,max_weight:50,minimum_height:1,
											 max_height:5,minimum_width:1,max_width:5,
											 minimum_length:10,max_length:15,price:0.5,shipping_company_id:1)
p linha 
p "Linha de preço pronta"

p linha
p "Carregando prazo estimado"
EstimatedDate.create!(min_distance:10 , max_distance:100, business_day: 3,shipping_company_id:1)
p linha 
p "Prazo estimado pronto"



#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
