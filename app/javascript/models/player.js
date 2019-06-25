import Card from './card'

class Player {
  constructor(player) {
    this._name = player.name
    this._cards = this.inflateCards(player.cards)
    this._matches = this.inflateCards(player.matches)
  }

  // Private method?
  inflateCards(cards) {
    return cards.map(card => new Card(card.rank, card.suit))
  }

  name() {
    return this._name
  }

  cards() {
    return this._cards
  }
}

export default Player
