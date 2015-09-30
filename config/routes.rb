Rails.application.routes.draw do
  resources :users, only: [:show]
  get '/users/:id/upvoted-episodes', to: 'users#show_upvoted_episodes', as: :user_upvoted

  resources :podcasts, only: [:show]
  resources :episodes, only: [:index, :create]
  resources :votes,    only: [:create]

  get '/get_episodes_data', to: 'episodes#get_episodes_data'

  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  root 'welcome#index'
end
