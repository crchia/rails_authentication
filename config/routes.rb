Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # routes for user login and signup
  # post 'auth/login', to: 'authentication#authenticate'
  
  post 'auth', to: 'sessions#create'
  get 'auth', to: 'sessions#show'
  delete 'auth', to: 'sessions#destroy'

  post 'signup', to: 'users#create'  
  put 'users', to: 'users#update'

  # Defines the root path route ("/")
  # root "articles#index"
end
