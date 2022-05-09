Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resources :users, only: %i[index show create update destroy ]
    resources :tweets, only: %i[index show create update destroy] do 
      resource :like, only: %i[create destroy]
    end
  end
end
