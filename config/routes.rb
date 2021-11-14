Rails.application.routes.draw do
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  resources :users
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
