require 'rails_helper'

RSpec.describe 'Create Game', type: :system do
  before do
    driven_by(:rack_test)
    visit '/'
  end

  it 'allows a user to create a game' do
    expect {
      fill_in 'Name', with: 'John'
      click_on 'Play'
      click_on 'Create Game'
      click_on 'Create'
    }.to change(Game, :count).by(1)
  end
end
