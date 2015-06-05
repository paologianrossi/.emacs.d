Rails.application.routes.draw do
  resources :users

  root to: 'visitors#landing'

  get 'thank_you' => 'visitors#thank_you', as: :thank_you
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
