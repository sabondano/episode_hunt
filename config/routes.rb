Rails.application.routes.draw do
  get '/ruby_rogues', to: 'episodes#ruby_rogues'
  post '/vote', to: 'votes#create'
  post '/episodes', to: 'episodes#create'
  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  root 'welcome#index'
  get '/dashboard', to: 'episodes#dashboard'
end
