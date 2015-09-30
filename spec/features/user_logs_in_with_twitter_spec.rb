require 'rails_helper'

feature 'user logs in with twitter' do
  before do
    stub_omniauth

    Podcast.create(name: "The Bike Shed",
                   feed_url: "http://simplecast.fm/podcasts/282/rss",
                   image: "http://simplecast-media.s3.amazonaws.com/podcast/image/282/1433513863-artwork.jpg",
                   link: "http://bikeshed.fm")

    Podcast.create(name: "Ruby Rogues",
                   feed_url: "http://feeds.feedwrench.com/RubyRogues.rss",
                   image: "https://s3.amazonaws.com/devchat.tv/ruby-rogues-thumb.jpg",
                   link: "http://rubyrogues.com")

    Podcast.create(name: "Giant Robots Smashing into other Giant Robots Podcast",
                   feed_url: "http://simplecast.fm/podcasts/271/rss",
                   image: "http://simplecast-media.s3.amazonaws.com/podcast/image/271/1437963534-artwork.jpg",
                   link: "http://giantrobots.fm/")

  end

  scenario 'logging in and logging out' do
    VCR.use_cassette 'features/user_logs_in' do
      visit root_path

      expect(page.status_code).to eq(200)

      click_link 'Log In'

      expect(current_path).to eq('/episodes')
      expect(page).to have_content('Sebastian')

      click_link 'Log out'

      expect(current_path).to eq('/')
      expect(page).to_not have_content('Sebastian')
      expect(page).to have_link('Log In')
    end
  end
end
