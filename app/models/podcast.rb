class Podcast < ActiveRecord::Base
  has_many :episodes

  def service
    @service ||= PodcastService.new(feed_url)
  end

  def most_popular_episodes
    episodes.order_by_popularity
  end

  def self.create_from_suggestion(podcast_suggestion_id)
    podcast_data = get_podcast_data(podcast_suggestion_id)
    if podcast_data.found_match? && !Podcast.exists?(name: podcast_data.name)
      PodcastSuggestion.update_status(podcast_suggestion_id, "approved")
      create(name: podcast_data.name,
             feed_url: podcast_data.feed_url,
             image: podcast_data.image)
    else
      "Sorry, podcast was not found or it already exists."
    end
  end

  private

  def self.get_podcast_data(podcast_suggestion_id)
    suggestion = PodcastSuggestion.find(podcast_suggestion_id).suggestion
    ItunesService.new(suggestion)
  end
end
