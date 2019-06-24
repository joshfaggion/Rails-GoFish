require 'rails_helper'

describe '#card_deck' do
  it 'should create the deck with 52 cards' do
    deck = Deck.new
    expect(deck.cards_left).to eq 52
  end

  it 'should shuffle the deck' do
    deck1 = Deck.new
    deck2 = Deck.new
    deck1.shuffle
    expect(deck1).to_not eq deck2
  end

  it 'can deal a starting hand' do
    deck = Deck.new
    expect(deck.deal.length).to eq 5
  end

  it 'should take on card and leave fifty-one' do
    deck = Deck.new
    deck.top_card
    expect(deck.cards_left).to eq 51
  end

  it 'converts to json' do
    deck = Deck.new
    deck.set_deck([Card.new(rank:'4', suit:'c'), Card.new(rank:'6', suit:'a')])
    expect(deck.as_json).to include_json({
      'cards': [{'rank': '4', 'suit':'c'}, {'rank': '6', 'suit': 'a'}]
      })
  end

  it 'converts from json' do
    doomed_deck = Deck.new
    doomed_deck.set_deck([Card.new(rank:'4', suit:'c'), Card.new(rank:'6', suit:'a')])
    json = doomed_deck.as_json
    new_deck = Deck.from_json(json)
    expect(new_deck.cards[0].rank).to eq '4'
    expect(new_deck.cards[0].suit).to eq 'c'
  end
end
