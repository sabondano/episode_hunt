require 'rails_helper'

feature 'admin user can approve or reject podcast suggestions', js: true do
  before do
    stub_omniauth
  end

  scenario 'successfully if they can be found through Itunes Search API'  do
    PodcastSuggestion.create(suggestion: "the bike shed")
    pending_suggestions_count = PodcastSuggestion.where(status: "pending").count

    visit root_path
    click_link 'Log In'
    User.first.update_attributes(role: 1) # to make user an admin
    click_link 'My Profile'
    first('.suggestions .btn-approve').click
    visit user_path(User.first)

    new_pending_suggestions_count = PodcastSuggestion.where(status: "pending").count

    expect(new_pending_suggestions_count).to eq(pending_suggestions_count - 1)
    expect(Podcast.count).to eq(1)
  end

  scenario 'unsuccessfully if they cant be found through Itunes Search API' do
    PodcastSuggestion.create(suggestion: "random test")
    pending_suggestions_count = PodcastSuggestion.where(status: "pending").count

    visit root_path
    click_link 'Log In'
    User.first.update_attributes(role: 1) # to make user an admin
    click_link 'My Profile'
    first('.suggestions .btn-approve').click
    visit user_path(User.first)

    new_pending_suggestions_count = PodcastSuggestion.where(status: "pending").count

    expect(new_pending_suggestions_count).to eq(pending_suggestions_count)
    expect(Podcast.count).to eq(0)
  end

  scenario 'when rejected, a suggestion will no longer appear as pending' do
    PodcastSuggestion.create(suggestion: "random test")
    pending_suggestions_count = PodcastSuggestion.where(status: "pending").count

    visit root_path
    click_link 'Log In'
    User.first.update_attributes(role: 1) # to make user an admin
    click_link 'My Profile'
    first('.suggestions .btn-reject').click
    visit user_path(User.first)

    new_pending_suggestions_count = PodcastSuggestion.where(status: "pending").count

    expect(new_pending_suggestions_count).to eq(pending_suggestions_count - 1)
    expect(Podcast.count).to eq(0)
    expect(page).to_not have_content("random test")
  end
end
