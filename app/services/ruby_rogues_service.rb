class RubyRoguesService
  attr_reader :response

  def initialize
    @response = Hurley.get("http://feeds.feedwrench.com/RubyRogues.rss")
    @response = Hash.from_xml(@response.body)
  end

  def episodes
    response["rss"]["channel"]["item"]
  end
end
