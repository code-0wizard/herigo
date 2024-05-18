Rails.application.routes.draw do
  root 'users#index'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  delete "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers, :like_reviews, :likers
    end
  end  
  resources :likes
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :heritages,           only: [:show, :index]
  resources :reviews,             only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
