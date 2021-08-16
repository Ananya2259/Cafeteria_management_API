Rails.application.routes.draw do
  # get "/" => "home#index"
  root to: "home#index"
  resources :users
  resources :main_menu
  resources :main
  resources :menu_categories
  resources :menu_items
  resources :cart_items
  # resources :orders
  resources :addresses
  get "/edit_profile" => "users#edit_profile", as: :edit_profile
  put "/update_profile" => "users#update_profile", as: :update_profile
  get "/edit_user" => "users#edit_user", as: :edit_user_detail
  put "/update_user" => "users#update_user", as: :update_user_detail
  get "/add_new_user" => "users#add_user", as: :add_new_user
  delete "/delete_user" => "users#destroy", as: :delete_user
  get "/order_items" => "order_items#create", as: :order_items
  get "/orders_create" => "orders#create", as: :orders
  patch "/orders_update" => "orders#update", as: :orders_update
  get "/orders_show" => "orders#show", as: :orders_show
  get "/orders_index" => "orders#index", as: :orders_index
  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session

  #Rest api resources
  namespace :api do
    namespace :v1 do
      resources :users
      resources :menu_items
      resources :menu_categories
      resources :cart_items
      resources :orders
      resources :order_items
      get "/display_users" => "users#display", as: :display_user
    end
  end
end
