require 'rails_helper'

feature 'user logs in with twitter' do
  before do
    stub_omniauth
  end

  scenario 'logging in and logging out' do
    VCR.use_cassette 'features/user_logs_in' do
      visit root_path

      expect(page.status_code).to eq(200)

      click_link 'Log In'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Sebastian')

      click_link 'Log out'

      expect(current_path).to eq('/')
      expect(page).to_not have_content('Sebastian')
      expect(page).to have_link('Log In')
    end
  end
end
