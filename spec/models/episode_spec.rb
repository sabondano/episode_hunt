require 'rails_helper'

RSpec.describe Episode, type: :model do
  it 'can create a new episode with correct data given a title' do
    VCR.use_cassette 'model/episode_create_from_title' do
      expect(Episode.all.count).to eq(0)

      user = User.create(screen_name: 'sabondano1')

      episode = Episode.create_from_title('056 RR David Heinemeier Hansson', user.id)

      expect(Episode.all.count).to eq(1)
      expect(Episode.first.votes.count).to eq(1)
      expect(episode.title).to eq('056 RR David Heinemeier Hansson')
      expect(episode.link).to eq('http://devchat.tv/ruby-rogues/056-rr-david-heinemeier-hansson')
      expect(episode.published_date).to eq('Fri, 08 Jun 2012 08:00:00 -0600')
      expect(episode.duration).to eq('1:16:25')
      expect(episode.audio_url).to eq('http://www.podtrac.com/pts/redirect.mp3/media.devchat.tv/ruby-rogues/RR056DHH.mp3?rss=true')
    end
  end

  it 'will not create an episode unless the title is unique' do
    VCR.use_cassette 'model/episode_create_from_title' do
      expect(Episode.all.count).to eq(0)

      user = User.create(screen_name: 'sabondano1')

      episode_1 = Episode.create_from_title('056 RR David Heinemeier Hansson', user.id)

      expect(Episode.all.count).to eq(1)

      episode_2 = Episode.create_from_title('056 RR David Heinemeier Hansson', user.id)

      expect(episode_2).to be_invalid
      expect(Episode.all.count).to eq(1)
    end
  end
end
