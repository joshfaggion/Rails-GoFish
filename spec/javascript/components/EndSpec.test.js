import { shallow } from 'enzyme'
import React from 'react'
import EndView from 'components/EndView'

global.fetch = jest.fn(() => new Promise(resolve => resolve()));


describe('EndView', () => {
  it('renders a basic game over title', () => {
    const wrapper = shallow(<EndView id={1} />)
    expect(wrapper.text()).toContain('Game Over')
  })
})
