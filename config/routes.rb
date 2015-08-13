Rails.application.routes.draw do
  root to: "static_pages#index"

  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:show]
  resources :orders, only: [:index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :addresses, only: [:new, :update, :create]

  get "/dashboard",    to: "users#show"

  patch "/account",    to: "users#update"
  post "/account",     to: "users#create"
  get "/account/new",  to: "users#new"
  get "/account/edit", to: "users#edit"

  get "/cart",         to: "cart_items#index"

  get "/login",        to: "sessions#new"
  post "/login",       to: "sessions#create"
  delete "/logout",    to: "sessions#destroy"

  namespace :admin do
    resources :products
    resources :orders, only: [:index, :show, :update]

    get "/",           to: "admins#index"
    get "/dashboard",  to: "admins#index"
  end

  get "/admin/ordered-orders",   to: "admin/orders#index_ordered"
  get "/admin/paid-orders",      to: "admin/orders#index_paid"
  get "/admin/cancelled-orders", to: "admin/orders#index_cancelled"
  get "/admin/completed-orders", to: "admin/orders#index_completed"

  resources :charges

  post 'twilio/connect_customer' => 'twilio#connect_customer'
end
