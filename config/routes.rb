Rails.application.routes.draw do
 
  get 'subscriptions/index'
  get 'subscriptions/new'
  get 'subscriptions/edit'

  resources :subscriptions
  resources :users, only: [:new, :create, :edit, :update]

  get '/signup', to: 'users#new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
