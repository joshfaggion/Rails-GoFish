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
    opponents: [{
      name: 'Charlie',
      cards: [],
      matches: [],
    }],
    log: ['Hello everybody!'],
    game_active: 'true',
  }

  it('renders a player\'s view', () => {
    const wrapper = shallow(<Game playerData={initialState} playerName="Josh" id={1} />)
    expect(wrapper.find('PlayerView').length).toBe(1)
  })

  it('updates the state', () => {
    const wrapper = shallow(<Game playerData={initialState} playerName="Josh" id={1} />)
    expect(wrapper.state().currentPlayer.name()).toBe(player.name)
  });

  it('renders opponents', () => {
    const wrapper = shallow(<Game playerData={initialState} playerName="Josh" id={1} />)
    expect(wrapper.find('Bot').length).toBe(1)
  });
})
