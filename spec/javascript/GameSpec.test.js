import { shallow } from 'enzyme'
import React from 'react'
import Game from 'components/Game'

global.fetch = jest.fn(() => new Promise(resolve => resolve()));


describe('Game', () => {
  it('renders a player\'s title', () => {
    const wrapper = shallow(<Game playerName="Josh" id={1} />)
    expect(wrapper.text()).toContain('Josh')
  });
});
