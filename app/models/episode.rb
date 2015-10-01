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
    CreateVoteJob.perform_later(episode.id, user_id)
    episode
  end

  def self.order_by_popularity
    joins(:votes)
    .select("episodes.*, COUNT(votes.id) AS vote_count")
    .group("episodes.id")
    .order("vote_count DESC")
    .to_a
  end

  private

  def self.get_episode_data(podcast_id, title)
    podcast = Podcast.find(podcast_id) 
    podcast.service.find_episode(title)
  end
end
