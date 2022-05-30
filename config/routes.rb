Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :shipping_companies, only: [:index,:show,:new, :create] do
    patch :active, on: :member
    patch :disable, on: :member
  end
  resources :transport_vehicles, only: [:new, :create,:show]
  resources :table_prices, only: [:show,:new,:create] do 
    get "search", on: :collection
    get "calculate", on: :collection
  end
  resources :orders, only: [:index,:new, :create,:show] do 
    get "choose_vehicle", on: :member
    patch "associate_shipping_company", on: :member
  end
  resources :estimated_dates, only: [:new, :create,:show]
  # Defines the root path route ("/")
  # root "articles#index"
end
