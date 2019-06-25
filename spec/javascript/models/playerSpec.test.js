import { shallow } from 'enzyme'
import React from 'react'
import Player from 'models/Player'

describe('Player', () => {
  const playerProps = {
    name: 'Charlos',
    cards: [{ rank: '10', suit: 's' }, { rank: 'a', suit: 'h' }],
    matches: [],
  }

  it('can inflate a hand of cards', () => {
    const player = new Player(playerProps)
    expect(player.cards()[0].rank()).toBe('10')
  });
})
