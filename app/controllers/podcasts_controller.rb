class PodcastsController < ApplicationController
  def show
    @podcasts   = Podcast.all
    podcast     = Podcast.find(params[:id])
    @episodes   = podcast.most_popular_episodes
  end
end
