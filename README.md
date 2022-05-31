<h1>Projeto 1° Etapa - CampusCode</h1>

<h2 align="center">Sistema de frete</h2>
<div>
  <img src="https://img.shields.io/badge/code--size-118%2C3%C2%A0MB-black">
  <img src="https://img.shields.io/badge/Status-Em%20desenvolvimento-yellow">
  <img src="https://img.shields.io/badge/ruby-ruby%203.1.2-red">
  <img src="https://img.shields.io/badge/rails-7.0.2.4-red">
</div>
  
<h2> Índice </h2>

* [Descrição do projeto](#Descrição-do-projeto)
* [Tecnologias Utilizadas](#Tecnologias-Utilizadas)
* [Funcionalidades](#Funcionalidades)
* [Gems Utilizadas](#Gems-Utilizadas)
* [Como iniciar o projeto](#Como-iniciar-o-projeto)

 <h2>Descrição do projeto</h2>
<p align="justify">O projeto tem como objetivo simular o sistema de frete de uma loja eletrônica. Este sistema de frete possui Administradores que cadastram novas transportadoras, criar novos pedidos ou apenas consultar um preço, Usuários de uma transportadora atualiza os dados de sua respectiva transportadora adicionando veículos, linhas na tabela de preço e estimativas de entrega. Um Administrador deve possuir uma conta de e-mail com o domínio: "@sistemadefrete.com" e um Usuário deve possuir um domínio de e-mail igual ao de uma transportadora já cadastrada.</p>

 <h2>Tecnologias Utilizadas</h2>

<ul>
<li>Ruby</li>  
<li>Ruby on rails</li>  
<li>CSS</li>
<li>HTML</li>  
</ul>

<h2>Funcionalidades</h2>
<ul>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
</ul>

<h2>Gems Utilizadas</h2>
<ul>
  <li><strong>Devise</strong>: foi utilizada para a criação dos tipos de conta na aplicação(Administradores e Usuários de transportadora) e sendo utilizada para limitação de acesso em certas contas</li> 
  <li><strong>Rspec</strong>: foi utilizada com o intuito de seguir a filosofia de TDD auxiliando na construção das funcionalidades, tornando o trabalho de escrever o código mais dinâmico</li> 
  <li><strong>Capybara</strong> complementando a gem anterior esta permitiu que os testes simulassem uma navegação real</li>  
</ul>

<h2>Como iniciar o projeto</h2>

<p align="justify">Para executar esse projeto você deve ter um computador, preferencialmente com Linux, com a linguagem de programação Ruby na versão 3.1.2. e o Rails 7.0.2.4.</p>

<p align="justify">No terminal do seu computador, clone este repositório utilizando o comando: <strong>$ git clone git@github.com:LucasDLAB/e-commerce-app.git.</strong> Ao clonar o projeto é necessário acessar o diretório utilizando o comando <strong> cd e-commerce-app</strong> e utilizar um outro comando que é o <strong>bundle install</strong> para instalar as dependências da aplicação.</p>

<p align="justify">Após instalar as dependências da aplicação já é possível acessar a aplicação, mas antes para carregar dados prédeterminados no banco de dados use <strong>rails db:seeds</strong>, agora utilizando o código <strong>rails server</strong>, ou resumidamente <strong>rails s</strong>, no terminal e no seu navegador acesse a rota localhost:3000</p>







