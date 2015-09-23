require 'rails_helper'

feature 'user submits episode' do
  before do
    stub_omniauth
  end

  scenario 'new episode' do
    visit root_path

    expect(page.status_code).to eq(200)

    click_link 'Log In'
    
    expect(current_path).to eq('/dashboard')

    page.find('#submit-episode').click

    select '056 RR David Heinemeier Hansson', from: 'Episodes'
    click_link 'Submit'

    expect(page).to have_css(".episode", count: 1)
  end
end
