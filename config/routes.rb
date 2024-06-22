Rails.application.routes.draw do
  root 'heritages#index'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  get '/logout', to: 'sessions#destroy'
  get '/search', to: 'searches#search'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations,    only: [:edit]
  resources :continents,             only: %i[edit update show]
  resources :password_resets,        only: %i[new create edit update]
  resources :heritages,              only: %i[new create edit update show index]
  resources :heritage_charms,        only: %i[new create edit update index]
  resources :email_resets,           only: %i[new create update]
  resources :reviews,                only: %i[create destroy show]
  resources :relationships,          only: %i[create destroy]
  resources :likes,                  only: %i[create destroy]
  resources :heritage_likes,         only: %i[create destroy show]
  resources :replies,                only: %i[create destroy]
end
