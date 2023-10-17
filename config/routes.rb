Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
 
  get 'subscriptions/index'
  get 'subscriptions/new'
  get 'subscriptions/edit'

  resources :subscriptions
  resources :users, only: [:new, :create, :edit, :update]

  get '/signup', to: 'users#new'
  get '/users/:user_id', to: 'home#index_logged_in'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
