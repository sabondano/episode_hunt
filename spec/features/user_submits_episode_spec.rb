require 'rails_helper'

feature 'user submits episode' do
  before do
    stub_omniauth

    Podcast.create(name: "Ruby Rogues",
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
  end

  scenario 'new episode' do
    VCR.use_cassette 'features/user_submits_an_episode' do
      visit root_path

      expect(page.status_code).to eq(200)

      click_link 'Log In'

      expect(current_path).to eq('/dashboard')
      page.find('#submit-episode').click

      select '056 RR David Heinemeier Hansson', from: 'episode'
      click_button 'Submit Episode'

      expect(page).to have_css(".episode", count: 2)
      expect(page).to have_content('Duration: 1:16:25')

      audio_url = find(:css, 'source')[:src]
      expect(audio_url).to eq('http://www.podtrac.com/pts/redirect.mp3/media.devchat.tv/ruby-rogues/RR056DHH.mp3?rss=true')
    end
  end
end
