require 'rails_helper'

feature 'user upvotes episode' do
  before do
    stub_omniauth

    user = User.create(screen_name: 'random')
    Episode.create(title: 'unique',
                   user_id: user.id)
  end

  scenario 'that he never voted for before' do
    VCR.use_cassette 'features/user_upvotes_episode' do
      visit root_path

      expect(page.status_code).to eq(200)

      click_link 'Log In'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_css(".episode", count: 2)

      visit '/ruby_rogues'
      within('.upvotes') do
        find(:css, 'button').click
      end
        upvotes = find('.upvote-value').text
        expect(upvotes).to eq('1')
    end
  end
end
