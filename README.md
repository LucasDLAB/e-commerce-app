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
<li>I18n</li>
</ul>

<h2>Funcionalidades</h2>
<ul>
  <li>Criação de contas:Para que a navegação na aplicação seja controlada, o acesso foi dividido entre dois tipos de contas (Administradores e Usuários de Transportadora)</li>
  <li>
    Administradores
    <ul>
      <li>Cria a conta de Administrador enviando o nome, email com o domínio @sistemadefrete.com e uma senha</li>
      <li>Cadastra novas Transportadoras ao sistema enviando apenas a Razão social,CNPJ(apenas os 14 números),o domínio de e-mail da empresa, rua, número, cidade, sigla do estado e a distância da transportadora para o depósito em Km</li>
      <li>As transportadoras terão automaticamente o valor mínimo de entrega de R$ 7,29</li>
      <li>Cria novos pedidos enviando o nome e cpf com os 10 números do destinatário, sua distância em Km, rua, número, cidade, sigla do estado, peso do pedido, medidas em em cm(Altura, Largura e Comprimento) e terá um código de identificação gerado automaticamente possuindo 15 caracteres alfanuméricos </li>
      <li>Visualizar os pedidos: Como administrador é possível visualizar todos os pedidos</li>
      <li>Faz um orçamento enviando as medidas em cm, distância em Km e o peso em Kg</li>
     </ul>
  </li>
  <li>Usuários de Transportadora
    <ul>
      <li>Cria a conta de Usuário de Transportadora  enviando o nome, email com o domínio da empresa e a extensão .com, e uma senha</li>
      <li>Cadastra novos veículos enviando a marca do veículo, ano de fabricação, capacidade máxima de carga em Kg, placa do veículo seguindo a convenção de 3 números e 4 letras, o modelo do veículo, medidas do baú do veículo em cm</li>
      <li>Adiciona intervalos na tabela de preço enviando o peso mínimo e máximo em Kg do intervalo, as medidas mínima e máxima do intervalo e o preço dessa linha da tabela</li>
      <li>Adiciona estimativas de prazo apenas enviando a distância mínima e máxima em Km do intervalo e o prazo em dias úteis</li>
      <li>Aceita novos pedidos, ao um novo pedido ser criado por um Administrador, o pedido automaticamente cria uma lista de transportadoras que atendem aos seus parâmetros sendo apresentado para uma de cada vez com base no menor preço, cabendo a transportadora requisitada aceitar</li>
    </ul>
  </li>
</ul>

<h2>Gems Utilizadas</h2>
<ul>
  <li><strong>Devise</strong>: foi utilizada para a criação dos tipos de conta na aplicação(Administradores e Usuários de transportadora) e sendo utilizada para limitação de acesso em certas contas</li> 
  <li><strong>Rspec</strong>: foi utilizada com o intuito de seguir a filosofia de TDD auxiliando na construção das funcionalidades, tornando o trabalho de escrever o código mais dinâmico</li> 
  <li><strong>Capybara</strong>: complementando a gem anterior esta permitiu que os testes simulassem uma navegação real</li>  
</ul>

<h2>Como iniciar o projeto</h2>

<p align="justify">Para executar esse projeto você deve ter um computador, preferencialmente com Linux, com a linguagem de programação Ruby na versão 3.1.2. e o Rails 7.0.2.4.</p>

<p align="justify">No terminal do seu computador, clone este repositório utilizando o comando: <strong>$ git clone git@github.com:LucasDLAB/e-commerce-app.git.</strong> Ao clonar o projeto é necessário acessar o diretório utilizando o comando <strong> cd e-commerce-app</strong> e utilizar um outro comando que é o <strong>bundle install</strong> para instalar as dependências da aplicação.</p>

<p align="justify">Após instalar as dependências da aplicação já é possível acessar a aplicação, mas antes para carregar dados prédeterminados no banco de dados use <strong>rails db:seeds</strong>, agora utilizando o código <strong>rails server</strong>, ou resumidamente <strong>rails s</strong>, no terminal e no seu navegador acesse a rota localhost:3000</p>







