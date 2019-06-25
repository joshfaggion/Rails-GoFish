import React from 'react';
import PropTypes from 'prop-types';

const hash = {}
const array = []
const suits = ['s', 'h', 'd', 'c']
const ranks = ['a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'j', 'q', 'k']
suits.forEach(suit => array.push(...ranks.map(rank => `${suit}${rank}`)))
array.forEach((card) => {
  hash[card] = require(`img/${card}.png`)
})
hash['cardBack'] = require('img/backs_blue.png')

class CardView extends React.Component {
  hello() {
    console.log('hello')
  }

  render() {
    return <img src="#" alt={this.props.card.value()} />
  }
}

CardView.propTypes = {
  card: PropTypes.object.isRequired,
}

export default CardView
