Teachabse::Application.routes.draw do
  resources :meetings, only: [:index]

  resources :users, only: [:index]
  resources :user_sessions, only: [:create]

  root 'meetings#index'

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  namespace :api do
    get '/meetings/search/:q', to: "meetings#search", as: :search_meetings
    
    resources :meetings
    resources :users
  end
end
