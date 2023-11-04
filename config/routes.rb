Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
 
  get 'subscriptions/index'
  get 'subscriptions/new'
  get 'subscriptions/edit'

  resources :subscriptions, only: [:new, :create, :index, :edit, :update, :destroy]
  resources :users, only: [:new, :create, :edit, :update]

  get '/signup', to: 'users#new'
  get '/users/:user_id', to: 'home#index_logged_in', as: 'user_profile'

  get '/recent_email_reminders', to: 'reminders#dropdown', as: 'reminders_dropdown'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
