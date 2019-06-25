import React from 'react'
import PropTypes from 'prop-types'
import CardView from './CardView'
import CardBack from '../img/backs_blue.png'

class Bot extends React.Component {
  class() {
    if (this.props.selectedPlayer === this.props.bot.name()) {
      return 'selected bot'
    }
    return 'bot'
  }

  render() {
    return (
      <div className={this.class()}>
        <h3><u>{this.props.bot.name()}</u></h3>
        {[...new Array(this.props.bot.cardAmount()).keys()].map(index => <img alt="Card Back" key={index} src={CardBack} />)}
      </div>
    )
  }
}

Bot.propTypes = {
  bot: PropTypes.object.isRequired,
  selectedPlayer: PropTypes.string.isRequired,
}

export default Bot
