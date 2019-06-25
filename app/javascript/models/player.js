import Card from './card'

class Player {
  constructor(props) {
    this._name = props['name']
    this._cards = this.inflateCards(props['cards'])
    this._matches = this.inflateCards(props['matches'])
  }

  inflateCards(cards) {
    return cards.map(card => new Card(card['rank'], card['suit']))
  }

  name() {
    return this._name
  }

  cards() {
    return this._cards
  }
}

export default Player
