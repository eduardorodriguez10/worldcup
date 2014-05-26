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
  get '/updateview', to: 'admin#change_view'
  get '/usersearch', to: 'admin#user_search'
  get '/admininfo', to: 'admin#admin_info'
  post '/teamupdate/:id', to: 'admin#team_update', as: 'teamupdate'
  get '/teamindex', to: 'admin#team_index' 
  get '/teamedit/:id', to: 'admin#team_edit', as: 'teamedit'
  get '/rules', to: 'rules#index', as:'rules'
  get '/groupinvite/:id', to: 'groups#invite_others', as: 'inviteothers'
  post '/sendinvite', to: 'groups#send_invite', as: 'sendinvite'
  get '/recoverpassword', to: 'users#recover_password', as: 'recoverpassword'
  post '/recover_password_email', to: 'users#recover_password_email', as: 'recover_password_email'
  get '/password_modify', to: 'users#password_modify', as: 'password_modify'
  get '/registerattempts', to: 'admin#register_attempts'
  get '/howdoesitwork', to: 'welcome#how_does_it_work'
  get '*path', to: 'welcome#index'
  end

