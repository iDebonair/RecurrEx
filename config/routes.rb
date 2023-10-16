Rails.application.routes.draw do
 
  get 'users/new'
  get 'users/edit'
  get 'subscriptions/index'
  get 'subscriptions/new'
  get 'subscriptions/edit'

  resources :subscriptions
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
