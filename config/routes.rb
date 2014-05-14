Rails.application.routes.draw do

  root :to => 'welcome#index'

  resources :brackets, except: :destroy
  resources :users, except: :destroy
  resources :groups
  resources :memberships

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get '/stats', to: 'stats#index'
  get '/wcbadmin', to: 'sessions#admin'
  post '/wcblogin', to: 'sessions#newadmin'
  get '/wcbmgmt', to: 'admin#index'
  get '/attempt', to: 'register_attempts#new'
  post '/attempt', to: 'register_attempts#create'
end
