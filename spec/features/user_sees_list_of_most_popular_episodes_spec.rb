require 'rails_helper'

feature 'user sees list of most popular episodes' do
  before do
    stub_omniauth

    podcast_1 = Podcast.create(name: "Ruby Rogues",
                               feed_url: "http://feeds.feedwrench.com/RubyRogues.rss",
                               image: "https://s3.amazonaws.com/devchat.tv/ruby-rogues-thumb.jpg",
                               link: "http://rubyrogues.com")

    podcast_2 = Podcast.create(name: "The Bike Shed",
                               feed_url: "http://simplecast.fm/podcasts/282/rss",
                               image: "http://simplecast-media.s3.amazonaws.com/podcast/image/282/1433513863-artwork.jpg",
                               link: "http://bikeshed.fm")

    podcast_3 = Podcast.create(name: "Giant Robots Smashing into other Giant Robots Podcast",
                               feed_url: "http://simplecast.fm/podcasts/271/rss",
                               image: "http://simplecast-media.s3.amazonaws.com/podcast/image/271/1437963534-artwork.jpg",
                               link: "http://giantrobots.fm/")

    user_1    = User.create(screen_name: 'mikey')
    user_2    = User.create(screen_name: 'tony')
    user_3    = User.create(screen_name: 'pedro')

    episode_1 = Episode.create(title: 'Cool Episode 1',
                               user_id: user_1.id,
                               podcast_id: podcast_1.id)

    episode_2 = Episode.create(title: 'Cool Episdoe 2',
                               user_id: user_2.id,
                               podcast_id: podcast_2.id)

    episode_3 = Episode.create(title: 'Cool Episode 3',
                               user_id: user_1.id,
                               podcast_id: podcast_3.id)

    Vote.create(user_id: user_1.id,
                episode_id: episode_3.id)

    [user_1, user_2, user_3].each do |user|
      Vote.create(user_id: user.id,
                  episode_id: episode_2.id)
    end

    [user_1, user_2].each do |user|
      Vote.create(user_id: user.id,
                  episode_id: episode_1.id) 
    end

  end


  scenario 'without filters (all episodes)' do
    VCR.use_cassette('features/user_sees_list_of_most_popular_episodes') do
      visit root_path

      expect(page.status_code).to eq(200)

      click_link 'Log In'

      expect(current_path).to eq('/all-episodes')
      expect(page).to have_css(".episode", count: 4) 
    end
  end

  scenario 'only ruby-rogues episodes' do
    VCR.use_cassette('features/user_sees_list_of_most_popular_episodes') do
      visit root_path

      expect(page.status_code).to eq(200)

      click_link 'Log In'

      visit ruby_rogues_path
      
      expect(page).to have_xpath("//img[@src='https://s3.amazonaws.com/devchat.tv/ruby-rogues-thumb.jpg']", count: 1)
      expect(page).to have_css(".episode", count: 2)
    end
  end
end
