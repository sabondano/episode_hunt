class PodcastSuggestionsController < ApplicationController
  def create
    PodcastSuggestion.create(suggestion: params["podcast suggestion"])
    flash[:success] = "Thank you for your submission."
    redirect_to new_podcast_path
  end
end
