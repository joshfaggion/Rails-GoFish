import { shallow } from 'enzyme'
import React from 'react'
import PlayerView from 'components/PlayerView'
import Player from 'models/player'

describe('PlayerView', () => {
  const playerProps = {
    name: 'Charlos',
    cards: [{ rank: '10', suit: 's' }, { rank: 'a', suit: 'h' }],
    matches: [],
  }

  it('renders a player\'s title', () => {
    const wrapper = shallow(<PlayerView selectedRank="10" updateSelectedRank={jest.fn()} isTurn="true" player={new Player(playerProps)} />)
    expect(wrapper.text()).toContain('Charlos')
  })

  it('renders a hand', () => {
    const wrapper = shallow(<PlayerView selectedRank="10" updateSelectedRank={jest.fn()} isTurn="true" player={new Player(playerProps)} />)
    expect(wrapper.find('CardView').length).toBe(2)
  });
})
