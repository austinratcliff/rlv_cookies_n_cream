Rails.application.routes.draw do
  root 'welcome#index'

  get '/signup', to: 'users#new'
  resources :users, only: [:create, :show, :edit, :update, :destroy]

  get '/login', to: 'sessions#new'
  resources :sessions, only: [:create, :destroy]

  resources :orders, only: [:new, :create, :show] do
    resources :pickups, only: [:new, :create]
    resources :deliveries, only: [:new, :create]
  end

  resources :messages, only: [:new, :create]

  get '/calendly', to: 'webhooks#calendly'
  post '/calendly_create', to: 'webhooks#calendly_create'
  post '/calendly_destroy', to: 'webhooks#calendly_destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
