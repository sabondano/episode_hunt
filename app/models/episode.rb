class Episode < ActiveRecord::Base
  validates :title, uniqueness: true

  belongs_to :user

  def self.create_from_title(title, user_id)
    episode = get_episode_data(title)
    Episode.create(title:          episode["title"],
                   link:           episode["link"],
                   published_date: episode["pubDate"],
                   duration:       episode["duration"],
                   audio_url:      episode["enclosure"]["url"],
                   user_id:        user_id)
  end

  private

  def self.get_episode_data(title)
    RubyRogues.find_episode(title)
  end
end
