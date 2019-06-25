import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'
import CardBack from '../img/backs_blue.png'

class Bot extends React.Component {
  twoPlusTwo() {
    return 2 + 2
  }

  render() {
    return (
      <div>
        <h3><u>{this.props.bot.name()}</u></h3>
        {[...new Array(this.props.bot.cardAmount()).keys()].map(index => <img alt="Card Back" key={index} src={CardBack} />)}
      </div>
    )
  }
}

Bot.propTypes = {
  bot: PropTypes.object.isRequired,
}

export default Bot
