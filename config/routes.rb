Rails.application.routes.draw do
  root 'heritages#index'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  get "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end  
  resources :account_activations,    only: [:edit]
  resources :continents,             only: [:edit, :update]
  resources :password_resets,        only: [:new, :create, :edit, :update]
  resources :heritages,              only: [:new, :create, :edit, :update, :show, :index]
  resources :heritage_first_charms,  only: [:new, :create, :edit, :update]
  resources :heritage_second_charms, only: [:new, :create, :edit, :update]
  resources :heritage_third_charms,  only: [:new, :create, :edit, :update]
  resources :heritage_fourth_charms, only: [:new, :create, :edit, :update]
  resources :reviews,                only: [:create, :destroy, :show]
  resources :relationships,          only: [:create, :destroy]
  resources :likes,                  only: [:create, :destroy]
  resources :heritage_likes,         only: [:create, :destroy]
  resources :replies,                only: [:create, :destroy]
end
