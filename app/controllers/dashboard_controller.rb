class DashboardController < ApplicationController
  before_action :authorize!

  def index
    @rr_episodes = RubyRogues.episode_titles
  end
end
