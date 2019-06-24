require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
    visit '/'

  end

  it 'allows a new user to sign up' do
    expect {
      fill_in 'Name', with: 'Bill'
      click_on 'Play'
    }.to change(User, :count).by(1)
  end

  it 'allows an existing user to login' do
    existing_user = User.create(name: 'Josh')
    visit '/'
    expect {
      fill_in 'Name', with: 'Josh'
      click_on 'Play'
    }.to_not change(User, :count)
  end
end
