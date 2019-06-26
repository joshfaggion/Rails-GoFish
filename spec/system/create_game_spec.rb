require 'rails_helper'

require_relative '../support/game_helper'


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
    session1, session2, session3, session4 = GameHelper.initialize_sessions

    GameHelper.login_users([session1, session2, session3, session4])

    session1.click_on 'Create Game'
    session1.click_on 'Create'

    GameHelper.join_game([session2, session3, session4])

    session2.driver.refresh
    expect(session2.text).to include 'Game 1 - in progress'
    expect(session2.text).to include 'Charlos2'
  end

  it 'plays through a turn' do
    session1, session2, session3, session4 = GameHelper.initialize_sessions

    GameHelper.login_users([session1, session2, session3, session4])

    session1.click_on 'Create Game'
    session1.click_on 'Create'

    GameHelper.join_game([session2, session3, session4])

    session1.driver.refresh
    card = session1.find('.player-card', match: :first)
    card.click
    expect(card.has_css?('.selected'))

    bot = session1.find('.bot', match: :first)
    bot.click
    expect(bot.has_css?('.selected'))

    request_button = session1.find('.request-button')
    request_button.click
    session1.driver.refresh

    expect(session1.all('.player-card').length).to_not eq 5
  end
end
