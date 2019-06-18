require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a new user to sign up' do
    visit '/'
    expect {
      fill_in 'Name', with: 'Josh'
      click_on 'Play'
    }.to change(User, :count).by(1)
  end
end
