class EpisodesController < ApplicationController
  before_action :authorize!

  def index
    @podcasts = Podcast.first(6)
    @episodes = Episode.order_by_popularity.paginate(page: params[:page], per_page: 5)
  end

  def create
    episode = Episode.create_from_title(params[:podcast], params[:episode], current_user.id)
    flash[:danger] = "Oh snap! That episode was already submitted. Upvote it "\
                     "instead!" if episode.invalid?
    redirect_to user_path(current_user)
  end

  def get_episodes_data
    podcast = Podcast.find(params[:podcast])

    render json: podcast.service.episode_titles
  end
end
