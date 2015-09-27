class EpisodesController < ApplicationController
  before_action :authorize!

  def dashboard
    @podcasts = Podcast.all
    @rr_episode_titles = Podcast.find_by(name: "Ruby Rogues").service.episode_titles
    @episodes = current_user.episodes
  end

  def create
    episode = Episode.create_from_title(params[:podcast], params[:episode], current_user.id)
    flash[:danger] = "Oh snap! That episode was already submitted. Upvote it instead!" if episode.invalid?
    redirect_to dashboard_path
  end

  def all_episodes
    @podcasts = Podcast.all
    @episodes = Episode.order_by_popularity

    render :dashboard
  end

  def ruby_rogues
    @podcasts   = Podcast.all
    ruby_rogues = Podcast.find_by(name: "Ruby Rogues")
    @episodes   = ruby_rogues.episodes.order_by_popularity

    render :dashboard
  end

  def giant_robots
    @podcasts   = Podcast.all
    giant_robots = Podcast.find_by(name: "Giant Robots Smashing into other Giant Robots Podcast")
    @episodes   = giant_robots.episodes.order_by_popularity

    render :dashboard
  end 

  def the_bike_shed
    @podcasts   = Podcast.all
    the_bike_shed = Podcast.find_by(name: "The Bike Shed")
    @episodes   = the_bike_shed.episodes.order_by_popularity
    render :dashboard
  end

  def get_episodes_data
    podcast = Podcast.find(params[:podcast])

    render json: podcast.service.episode_titles
  end
end
