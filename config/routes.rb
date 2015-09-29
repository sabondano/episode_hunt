Rails.application.routes.draw do
  resources :users, only: [:show]
  get '/users/:id/upvoted-episodes', to: 'users#show_upvoted_episodes', as: :user_upvoted

  get '/all-episodes', to: 'episodes#all_episodes'
  get '/get_episodes_data', to: 'episodes#get_episodes_data'
  get '/ruby-rogues', to: 'episodes#ruby_rogues'
  get '/giant-robots', to: 'episodes#giant_robots'
  get '/the-bike-shed', to: 'episodes#the_bike_shed'

  post '/vote', to: 'votes#create'
  post '/episodes', to: 'episodes#create'
  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  root 'welcome#index'
  get '/dashboard', to: 'episodes#dashboard'
end
