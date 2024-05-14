Rails.application.routes.draw do
  get 'git_sessions/new'
  get 'google_login_api/callback'
  get 'static_pages/before_login'
  get 'static_pages/after_login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  #root "home#index"

  root 'static_pages#before_login'
  get '/after_login', to: 'static_pages#after_login'
  post '/google_login_api/callback', to: 'google_login_api#callback'

  get '/auth/github', to: 'git_sessions#new', as: :github_login
  get '/auth/github/callback', to: 'git_sessions#create'
end
