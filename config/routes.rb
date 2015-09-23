Rails.application.routes.draw do
  post 'episodes', to: 'episodes#create'
  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  root 'welcome#index'
  get '/dashboard', to: 'dashboard#index'
end
