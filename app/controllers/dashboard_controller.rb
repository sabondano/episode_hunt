class DashboardController < ApplicationController
  before_action :authorize!

  def index
    @rr_episode_titles = RubyRogues.episode_titles
    @episodes = current_user.episodes
  end
end
