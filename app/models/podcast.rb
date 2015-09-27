class Podcast < ActiveRecord::Base
  has_many :episodes

  def service
    @service ||= PodcastService.new(feed_url)
  end

end
