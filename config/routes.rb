Rails.application.routes.draw do
  resources :places
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'admin', to: 'users#admin', as: 'admin'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"


end
