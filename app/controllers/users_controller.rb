class UsersController < ApplicationController
  before_action :authorize! 

  def index
    @podcasts = Podcast.first(6)
    @users    = User.all
  end

  def show
    @podcasts = Podcast.first(6)
    @user     = User.find(params[:id])
    @episodes = @user.episodes.paginate(page: params[:page], per_page: 5)
    @podcast_suggestions = PodcastSuggestion.where(status: "pending") if current_admin?
  end

  def show_upvoted_episodes
    @podcasts = Podcast.first(6)
    @user     = User.find(params[:id])
    @episodes = @user.upvoted_episodes.paginate(page: params[:page], per_page: 5)
  end
end
