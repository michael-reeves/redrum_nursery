Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]
  resources :users, only: [:index, :new, :create, :edit, :update]
  resources :orders, only: [:index, :show]

  get "/dashboard", to: "users#show"

  get "/cart", to: "cart_items#index"
  resources :cart_items, only: [:create, :update, :destroy]

  get "/login",  to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    get "/dashboard", to: "admins#index"
    resources :products
    resources :orders, only: [:index, :show, :update]
  end

  get "/admin/ordered-orders", to: "admin/orders#index_ordered"
  get "/admin/paid-orders", to: "admin/orders#index_paid"
  get "/admin/cancelled-orders", to: "admin/orders#index_cancelled"
  get "/admin/completed-orders", to: "admin/orders#index_completed"

  resources :charges
end
