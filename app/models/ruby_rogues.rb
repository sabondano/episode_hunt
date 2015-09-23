class RubyRogues
  def self.service
    @service ||= RubyRoguesService.new
  end

  def self.episode_titles
    service.episodes.map { |episode| episode["title"] }
  end 

  def self.find_episode(title)
    service.episodes.find do |episode|
      episode["title"] == title
    end
  end
end
