import React from 'react'
import PropTypes from 'prop-types'

const hash = {}
const array = []
const suits = ['s', 'h', 'd', 'c']
const ranks = ['a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'j', 'q', 'k']
suits.forEach(suit => array.push(...ranks.map(rank => `${suit}${rank}`)))
array.forEach((card) => {
  hash[card] = require(`../img/${card}.png`)
})
hash['cardBack'] = require('img/backs_blue.png')

class CardView extends React.Component {
  source() {
    return hash[this.props.card.value()]
  }

  class() {
    if (this.props.selectedRank === this.props.card.rank()) {
      return `selected card ${this.props.class}`
    }
    return `${this.props.class} card`
  }

  cardClicked() {
    if (this.props.isTurn === 'true') {
      this.props.updateSelectedRank(this.props.card.rank())
    }
  }

  render() {
    return <img src={this.source()} onClick={this.cardClicked.bind(this)} className={this.class()} alt={this.props.card.value()} />
  }
}

CardView.propTypes = {
  card: PropTypes.object.isRequired,
  selectedRank: PropTypes.string,
  updateSelectedRank: PropTypes.func,
  isTurn: PropTypes.string.isRequired,
  class: PropTypes.string,
}

export default CardView
