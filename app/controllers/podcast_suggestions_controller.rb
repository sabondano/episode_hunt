class PodcastSuggestionsController < ApplicationController
  def create
    PodcastSuggestion.create(suggestion: params["podcast suggestion"])
    flash[:success] = "Thank you for your submission."
    redirect_to new_podcast_path
  end

  def update
    podcast_suggestion = PodcastSuggestion.find(params["id"]).update_attributes(status: "rejected")

    respond_to do |format|
      format.json { render json: { head: "ok" } }
    end
  end
end
