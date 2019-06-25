import { shallow } from 'enzyme'
import React from 'react'
import BotView from 'components/BotView'
import Bot from 'models/Bot'

describe('Bot', () => {
  const botProps = {
    name: 'Charlos',
    card_amount: 3,
    matches: [],
  }

  it('renders a player\'s title', () => {
    const wrapper = shallow(<BotView bot={new Bot(botProps)} />)
    expect(wrapper.text()).toContain('Charlos')
  })

  it('renders a hand', () => {
    const wrapper = shallow(<BotView bot={new Bot(botProps)} />)
    expect(wrapper.find('img').length).toBe(3)
  });
})
