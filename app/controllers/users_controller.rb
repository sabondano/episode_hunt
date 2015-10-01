class UsersController < ApplicationController
  before_action :authorize! 

  def show
    @podcasts = Podcast.first(6)
    @user     = User.find(params[:id])
    @episodes = @user.episodes
    @podcast_suggestions = PodcastSuggestion.where(status: "pending") if current_admin?
  end

  def show_upvoted_episodes
    @podcasts = Podcast.first(6)
    @user     = User.find(params[:id])
    @episodes = @user.upvoted_episodes
  end
end
