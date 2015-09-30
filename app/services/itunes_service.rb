class ItunesService
  attr_reader :podcast_data

  def initialize(search_term)
    @podcast_data = Hurley.get("https://itunes.apple.com/search?term=#{URI.escape(search_term)}&entity=podcast")
  end

  def name
    parse(podcast_data)[:results].first[:collectionName]
  end

  def feed_url
    parse(podcast_data)[:results].first[:feedUrl]
  end

  def image
    parse(podcast_data)[:results].first[:artworkUrl600]
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true) 
  end
end
