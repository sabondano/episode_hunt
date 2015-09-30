Rails.application.routes.draw do
  get '/users/:id/upvoted-episodes', to: 'users#show_upvoted_episodes', as: :user_upvoted

  resources :users,               only: [:show]
  resources :podcasts,            only: [:show, :new, :create]
  resources :episodes,            only: [:index, :create]
  resources :votes,               only: [:create]
  resources :podcast_suggestions, only: [:create]

  get '/get_episodes_data', to: 'episodes#get_episodes_data'

  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  root 'welcome#index'
end
