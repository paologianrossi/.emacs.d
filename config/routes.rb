Rails.application.routes.draw do
  resources :slings
  resources :users, except: [:new]

  root to: 'visitors#homepage', constraints: lambda{ |req| req.session[:user_id].blank? }
  root to: 'users#index', as: :sioola_root

  get 'thank_you' => 'visitors#thank_you', as: :thank_you

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
