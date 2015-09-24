class EpisodesController < ApplicationController
  before_action :authorize!

  def dashboard
    @rr_episode_titles = RubyRogues.episode_titles
    @episodes = current_user.episodes
  end

  def create
    episode = Episode.create_from_title(params[:episode], current_user.id)
    flash[:danger] = "Oh snap! That episode was already submitted. Upvote it instead!" if episode.invalid?
    redirect_to dashboard_path
  end

  def ruby_rogues
    @rr_episode_titles = RubyRogues.episode_titles
    @episodes = Episode.joins(:votes)
                       .select("episodes.*, COUNT(votes.id) AS vote_count")
                       .group("episodes.id")
                       .order("vote_count DESC")
                       .to_a
    render :dashboard
  end
end
