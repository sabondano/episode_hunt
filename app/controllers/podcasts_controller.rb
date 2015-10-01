class PodcastsController < ApplicationController
  def show
    @podcasts   = Podcast.all
    podcast     = Podcast.find(params[:id])
    @episodes   = podcast.most_popular_episodes
  end

  def new
    @podcasts = Podcast.all
  end

  def create
    podcast = Podcast.create_from_suggestion(params["podcast_suggestion_id"])
    
    if podcast.is_a?(Podcast)
      respond_to do |format|
        format.json { render json: { head: "ok" } }
      end
    else
      respond_to do |format|
        format.json { render json: podcast, status: 422 }
      end
    end
  end
end
