require 'rails_helper'

feature 'user submits episode' do
  before do
    stub_omniauth
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
