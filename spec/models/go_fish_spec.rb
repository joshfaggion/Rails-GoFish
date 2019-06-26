require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'can initialize with the correct state' do
    game = GoFish.new(names: ['Cameron', 'Josh'], player_count: 2)
    game.start_game
    expect(game.players[0].cards_left).to eq 5
    expect(game.deck.cards_left).to eq (52 - 10)
  end

  it 'can run a round' do
    game = GoFish.new(names: ['Cameron', 'Josh'], player_count: 2)
    game.start_game
    game.play_round('Cameron', 'Josh', '10')
    expect(game.players()[0].cards_left).to_not eq 5
  end

  it 'can convert to json' do
    game = GoFish.new(names: ['Cameron', 'Josh'], player_count: 2)
    game.start_game
    json = game.as_json
    deck = game.deck
    player1 = game.players[0]
    player2 = game.players[1]
    expect(json).to include_json({
      players: [player1.as_json, player2.as_json],
      deck: deck.as_json
      })
  end

  it 'can convert from json' do
    game = GoFish.new(names:['Cameron', 'Josh'], player_count: 2)
    game.start_game
    json = game.as_json
    new_game = GoFish.from_json(json)
    expect(new_game.players[0].cards_left).to eq 5
  end

  it 'can get state for a player' do
    game = GoFish.new(names: ['Charlos', 'Finn'], player_count: 2)
    game.start_game
    state = game.state_for('Finn')
    expect(state['is_turn']).to eq 'false'
    expect(state['player']['cards'].length).to eq 5
  end
end
