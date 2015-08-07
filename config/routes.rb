Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]
  resources :orders, only: [:index]

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
end
