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

  it('renders a player\'s title', () => {
    const wrapper = shallow(<Game initialState={initialState} playerName="Josh" id={1} />)
    expect(wrapper.text()).toContain('Josh')
  })

  it('updates the state', () => {
    const wrapper = shallow(<Game initialState={initialState} playerName="Josh" id={1} />)
    expect(wrapper.state().currentPlayer).toBe(player)
  });

  it('renders the cards', () => {
    const wrapper = shallow(<Game initialState={initialState} playerName="Josh" id={1} />)
    expect(wrapper.find('img').length).toBe(10)
  });
})
