Rails.application.routes.draw do
  root 'welcome#index'

  get '/signup', to: 'users#new'
  resources :users, only: [:create, :show, :edit, :update, :destroy]

  get '/login', to: 'sessions#new'
  resources :sessions, only: [:create, :destroy]

  resources :orders do
    resources :pickups, only: [:new, :create, :edit, :update]
    resources :deliveries, only: [:new, :create, :edit, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
