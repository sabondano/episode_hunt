class PodcastsController < ApplicationController
  def show
    @podcasts   = Podcast.first(6)
    podcast     = Podcast.find(params[:id])
    @episodes   = podcast.most_popular_episodes.paginate(page: params[:page], per_page: 5)
  end

  def new
    @podcasts = Podcast.first(6)
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
