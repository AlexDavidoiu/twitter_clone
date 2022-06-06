Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  namespace :api do
    resources :users, only: %i[index show create update destroy]
    resources :tweets, only: %i[index show create update destroy] do 
      resource :like, only: %i[create destroy]
    end

    post '/auth/login', to: 'authentication#login'
    get '/*a', to: 'application#not_found'
  end

  root "welcome#index"

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/profile", to: "users#profile"
  get "/profile/edit", to: "users#edit"
  put "/profile", to: "users#update"

  resources :tweets, only: %i[index new create]

  get 'register', to: 'registrations#new'
  post 'register', to: 'registrations#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: 'sessions#destroy'

  post "/graphql", to: "graphql#graphql"
end
