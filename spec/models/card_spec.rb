require 'rails_helper'

describe '#card' do
  it 'returns the rank and suit' do
    card = Card.new(rank:'10', suit:'s')
    expect(card.rank).to eq '10'
    expect(card.suit).to eq 's'
  end

  it 'converts to json' do
    card = Card.new(rank:'a', suit:'h')
    expect(card.as_json).to include_json({
      'rank': "a",
      'suit': "h"
    })
  end

  it 'converts from json' do
    card = Card.new(rank:'a', suit:'h')
    json = card.as_json
    new_card = Card.from_json(json)
    expect(new_card.rank).to eq 'a'
    expect(new_card.suit).to eq 'h'
  end
end
