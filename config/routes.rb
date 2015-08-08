Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]
  resources :users, only: [:index, :new, :create]

  get "/dashboard", to: "users#show"

  get "/cart", to: "cart_items#index"
  resources :cart_items, only: [:create, :update]

  get "/login",  to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
