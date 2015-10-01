class UsersController < ApplicationController
  before_action :authorize! 

  def show
    @podcasts = Podcast.all
    @user     = User.find(params[:id])
    @episodes = @user.episodes
    @podcast_suggestions = PodcastSuggestion.where(status: "pending")
  end

  def show_upvoted_episodes
    @podcasts = Podcast.all
    @user     = User.find(params[:id])
    @episodes = @user.upvoted_episodes
  end
end
