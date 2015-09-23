class RubyRogues
  def self.service
    @service ||= RubyRoguesService.new
  end

  def self.episode_titles
    service.episodes.map { |episode| episode["title"] }
  end 
end
