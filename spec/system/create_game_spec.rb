require 'rails_helper'

require_relative '../support/game_helper'


RSpec.describe 'Create Game', type: :system do
  it 'allows a user to create a game' do
    driven_by(:rack_test)
    visit '/'
    expect {
      fill_in 'Name', with: 'John'
      click_on 'Play'
      click_on 'Create Game'
      click_on 'Create'
    }.to change(Game, :count).by(1)
  end

  # Test rework

  it 'joins a game and plays through a turn' do
    session1, session2 = GameHelper.initialize_sessions
    game = Game.create(player_count: 2)

    GameHelper.login_users([session1, session2])

    GameHelper.join_two_player_game([session1, session2], game)

    session1.driver.refresh
    card = session1.all('.player-card').last
    card.click
    expect(card.has_css?('.selected'))

    bot = session1.find('.bot-div', match: :first)
    bot.click
    expect(bot.has_css?('.selected'))

    request_button = session1.find('.request-button')
    request_button.click
    session1.driver.refresh

    expect(session1.all('.player-card').length).to_not eq 5
  end

  it 'can play til an end game' do
    session1 = Capybara::Session.new(:selenium_chrome_headless, Rails.application)
    user1 = User.create(name: "Charlos1")
    user2 = User.create(name: "Charlos2")
    game = Game.create(started_at: Time.now, player_count: 2, go_fish: GameHelper.finished_game([user1, user2]))
    game_user1 = GameUser.create(game_id: game.id, user_id: user1.id)
    game_user2 = GameUser.create(game_id: game.id, user_id: user2.id)

    GameHelper.login_users([session1])

    session1.visit "/games/#{game.id}"

    card = session1.all('.player-card').last
    card.click

    bot = session1.find('.bot-div', match: :first)
    bot.click

    request_button = session1.find('.request-button')
    request_button.click

    session1.driver.refresh
    expect(session1.text).to have_text('Game Over')
    expect(session1.text).to have_text('Charlos1 had 3 point(s)')

  end
end
