Rails.application.routes.draw do
  resources :projects, except: [ :destroy ]
  # Métodos no accounts_controller.rb
  resources :accounts, except: [ :destroy ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Métodos no authentication_controller.rb
  post "/auth/login", to: "authentication#login"
  get "/auth/decode", to: "authentication#decode"

  get "/*a", to: "application#not_found"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
