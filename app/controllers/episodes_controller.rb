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
    @episodes = Episode.joins(:votes)
                       .select("episodes.*, COUNT(votes.id) AS vote_count")
                       .group("episodes.id")
                       .order("vote_count DESC")
                       .to_a

    render :dashboard
  end

  def ruby_rogues
    @podcasts   = Podcast.all
    ruby_rogues = Podcast.find_by(name: "Ruby Rogues")
    @episodes   = ruby_rogues.episodes
                             .joins(:votes)
                             .select("episodes.*, COUNT(votes.id) AS vote_count")
                             .group("episodes.id")
                             .order("vote_count DESC")
                             .to_a

    render :dashboard
  end

  def get_episodes_data
    podcast = Podcast.find(params[:podcast])

    render json: podcast.service.episode_titles
  end
end
