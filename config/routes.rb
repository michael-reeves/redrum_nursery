Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]

  get "/cart", to: "cart_items#index"
  resources :cart_items, only: [:create, :update]
end
