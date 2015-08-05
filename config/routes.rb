Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :products, only: [:index, :show]

  get "/cart", to: "cart_items#index"
end
