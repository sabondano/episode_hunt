require 'rails_helper'

feature 'user suggests a podcast' do
  before do
    stub_omniauth
  end

  scenario 'that we can find through iTunes API' do
    visit root_path
    click_link 'Log In'
    click_link 'Suggest a podcast'
    fill_in 'podcast suggestion', with: 'the bike shed'
    click_button 'Submit Podcast'

    expect(page).to have_content("Thank you for your submission.")
    expect(PodcastSuggestion.count).to eq(1)
  end
end
