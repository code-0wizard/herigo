Rails.application.routes.draw do
  root 'users#index'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  delete "/logout",  to: "sessions#destroy"
  resources :users
end
