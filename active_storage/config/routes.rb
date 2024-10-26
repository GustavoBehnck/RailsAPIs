Rails.application.routes.draw do
  resources :projects do
    get "keywords", to: "keywords#index"
    # get "/images", to: "images#index"
  end

  get "/search_keywords", to: "keywords#search"
  # post "/images", to: "images#create"

  resources :accounts

  post "/auth/login", to: "authentication#login"
  get "/auth/decode", to: "authentication#decode"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
