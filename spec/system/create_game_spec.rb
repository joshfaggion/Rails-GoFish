require 'rails_helper'

RSpec.describe 'Create Game', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a user to create a game' do
    visit '/'
    expect {
      fill_in 'Name', with: 'John'
      click_on 'Play'
      click_on 'Create Game'
      click_on 'Create'
    }.to change(Game, :count).by(1)
  end

  it 'allows users to join the game' do
    session1 = Capybara::Session.new(:selenium_chrome_headless, Rails.application)
    session2 = Capybara::Session.new(:selenium_chrome_headless, Rails.application)
    session3 = Capybara::Session.new(:selenium_chrome_headless, Rails.application)
    session4 = Capybara::Session.new(:selenium_chrome_headless, Rails.application)

    [session1, session2, session3, session4].each_with_index do |session, index|
      session.visit '/'
      session.fill_in 'Name', with: "Charlos#{index + 1}"
      session.click_on 'Play'
    end

    session1.click_on 'Create Game'
    session1.click_on 'Create'

    [session2, session3, session4].each do |session|
      session.driver.refresh
      session.click_on 'Join Game 1 - waiting for players'
    end

    session2.driver.refresh
    expect(session2.text).to include 'Game 1 - in progress'
    expect(session2.text).to include 'Charlos2'
  end
end
