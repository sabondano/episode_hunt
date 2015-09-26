class PodcastService
  attr_reader :response

  def initialize(feed_url)
    @response = Hurley.get(feed_url)
    @response = Hash.from_xml(@response.body)
  end

  def episodes
    response["rss"]["channel"]["item"]
  end

  def episode_titles
    episodes.map { |episode| episode["title"] }
  end

  def find_episode(title)
    episodes.find do |episode|
      episode["title"] == title
    end
  end
end
