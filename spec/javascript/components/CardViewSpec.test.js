import { shallow } from 'enzyme'
import React from 'react'
import CardView from 'components/CardView'
import Card from 'models/card'

describe('CardView', () => {
  const cardProps = {
    rank: '10',
    suit: 'h',
  }

  it('renders a card', () => {
    const wrapper = shallow(<CardView card={new Card(cardProps)} />)
    expect(wrapper.find('img').length).toBe(1)
  })
})
