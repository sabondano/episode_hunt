class Podcast < ActiveRecord::Base
  has_many :episodes

  def service
    @service ||= PodcastService.new(feed_url)
  end

  def most_popular_episodes
    episodes.order_by_popularity
  end
end
