class EpisodesController < ApplicationController
  before_action :authorize!

  def create
    episode = Episode.create_from_title(params[:episode], current_user.id)
    flash[:danger] = "Oh snap! That episode was already submitted. Upvote it instead!" if episode.invalid?
    redirect_to dashboard_path
  end

  def ruby_rogues
    @rr_episode_titles = RubyRogues.episode_titles
    @episodes = Episode.all
    render 'dashboard/index'
  end
end
