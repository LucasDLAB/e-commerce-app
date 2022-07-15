# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :shipping_companies, only: %i[index show new create] do
    patch :active, on: :member
    patch :disable, on: :member
  end
  resources :transport_vehicles, only: %i[new create show]
  resources :table_prices, only: %i[show new create] do
    get 'search', on: :collection
    get 'calculate', on: :collection
  end
  resources :orders, only: %i[index new create show] do
    get 'choose_vehicle', on: :member
    patch 'associate_shipping_company', on: :member
  end
  resources :estimated_dates, only: %i[new create show]
  # Defines the root path route ("/")
  # root "articles#index"
end
