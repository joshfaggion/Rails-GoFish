import { shallow } from 'enzyme'
import React from 'react'
import Game from 'components/Game'

global.fetch = jest.fn(() => new Promise(resolve => resolve()));


describe('Game', () => {
  const player = {
    name: 'Josh',
    cards: [],
    matches: [],
  }

  const initialState = {
    is_turn: 'true',
    player,
  }

  it('renders a player\'s view', () => {
    const wrapper = shallow(<Game playerData={initialState} playerName="Josh" id={1} />)
    expect(wrapper.find('PlayerView').length).toBe(1)
  })

  it('updates the state', () => {
    const wrapper = shallow(<Game playerData={initialState} playerName="Josh" id={1} />)
    expect(wrapper.state().currentPlayer.name()).toBe(player.name)
  });

  it('renders the cards', () => {
    const wrapper = shallow(<Game playerData={initialState} playerName="Josh" id={1} />)
    expect(wrapper.find('img').length).toBe(10)
  });
})
