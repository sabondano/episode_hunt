require 'rails_helper'

feature 'user upvotes episode' do
  before do
    stub_omniauth

    podcast = Podcast.create(name: "Ruby Rogues",
                             feed_url: "http://feeds.feedwrench.com/RubyRogues.rss",
                             image: "https://s3.amazonaws.com/devchat.tv/ruby-rogues-thumb.jpg",
                             link: "http://rubyrogues.com")

    Podcast.create(name: "The Bike Shed",
                   feed_url: "http://simplecast.fm/podcasts/282/rss",
                   image: "http://simplecast-media.s3.amazonaws.com/podcast/image/282/1433513863-artwork.jpg",
                   link: "http://bikeshed.fm")

    Podcast.create(name: "Giant Robots Smashing into other Giant Robots Podcast",
                   feed_url: "http://simplecast.fm/podcasts/271/rss",
                   image: "http://simplecast-media.s3.amazonaws.com/podcast/image/271/1437963534-artwork.jpg",
                   link: "http://giantrobots.fm/")

    user    = User.create(screen_name: 'random')

    episode = Episode.create(title: 'unique',
                             user_id: user.id,
                             podcast_id: podcast.id)
   
    Vote.create(user_id: user.id, episode_id: episode.id)
  end

  scenario 'that he never voted for before' do
    VCR.use_cassette 'features/user_upvotes_episode' do
      visit root_path

      expect(page.status_code).to eq(200)

      click_link 'Log In'

      expect(current_path).to eq('/all-episodes')
      expect(page).to have_css(".episode", count: 2)

      visit '/ruby-rogues'
      expect(current_path).to eq('/ruby-rogues')

      within('.upvotes') do
        find(:css, 'button').click
      end
      upvotes = find('.upvote-value').text
      expect(upvotes).to eq('2')
    end
  end
end
