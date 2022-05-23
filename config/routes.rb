Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :shipping_companies, only: [:index,:show,:new, :create]
  resources :transport_vehicles, only: [:new, :create]
  resources :table_prices
  # Defines the root path route ("/")
  # root "articles#index"
end
