Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]
  resources :users, only: [:index, :new, :create]
  resources :orders, only: [:index]

  get "/dashboard", to: "users#show"

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
