require 'rails_helper'

describe '#player' do
  before(:each) do
    @player = Player.new(name: 'Carl')
  end

  it 'should initialize with zero cards' do
    expect(@player.cards_left).to eq 0
  end

  it 'should return a card if requested correctly' do
    card = Card.new(rank:'10', suit:'h')
    @player.set_hand([card])
    result = @player.card_in_hand('10')
    expect(result).to eq [card]
  end

  it 'should return go fish if requested incorrectly' do
    card = Card.new(rank:'10', suit:'h')
    @player.set_hand([card])
    result = @player.card_in_hand('j')
    expect(result).to eq 'Go Fish!'
  end

  it 'should take a card' do
    card = Card.new(rank:'10', suit:'c')
    @player.take_cards(card)
    expect(@player.cards_left).to eq 1
  end

  it 'can pair cards' do
    array_of_cards = ['s', 'c', 'h', 'd'].map { |suit| Card.new(rank:"4", suit:"#{suit}")}
    player = Player.new(name: 'Carlos', cards: array_of_cards)
    player.pair_cards
    expect(player.cards_left).to eq 0
    expect(player.points()).to eq 1
  end

  it 'converts to json' do
    @player.set_hand([Card.new(rank:'10', suit:'h'), Card.new(rank:'j', suit:'c')])
    json = @player.as_json
    expect(json).to include_json({
      'cards': [{'rank': '10', 'suit': 'h'}, {'rank': 'j', 'suit': 'c'}],
      'name': 'Carl'
      })
  end

  it 'converts from json' do
    @player.set_hand([Card.new(rank:'10', suit:'h'), Card.new(rank:'j', suit:'c')])
    json = @player.as_json
    new_player = Player.from_json(json)
    expect(new_player.name).to eq 'Carl'
  end
end
