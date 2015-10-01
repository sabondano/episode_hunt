class PodcastSuggestion < ActiveRecord::Base
  def self.update_status(podcast_suggestion_id, status)
    find(podcast_suggestion_id).update_attributes(status: status)
  end
end
