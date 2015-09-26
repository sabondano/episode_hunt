class Episode < ActiveRecord::Base
  validates :title, uniqueness: true

  has_many :votes
  belongs_to :user
  belongs_to :podcast

  def self.create_from_title(podcast_id, title, user_id)
    episode = get_episode_data(podcast_id, title)
    episode = Episode.create(title:          episode["title"],
                             link:           episode["link"],
                             published_date: episode["pubDate"],
                             duration:       episode["duration"],
                             audio_url:      episode["enclosure"]["url"],
                             user_id:        user_id,
                             podcast_id:     podcast_id)
    Vote.create(episode_id: episode.id,
                user_id:    user_id)
    episode
  end

  private

  def self.get_episode_data(podcast_id, title)
    podcast = Podcast.find(podcast_id) 
    podcast.service.find_episode(title)
  end
end
