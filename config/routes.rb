Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]
  resources :users, only: [:new, :index]

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
end
