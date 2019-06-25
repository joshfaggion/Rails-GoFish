import Card from './card'

class Bot {
  constructor(bot) {
    this._name = bot.name
    this._cardAmount = bot.card_amount
    this._matches = this.inflateCards(bot.matches)
  }

  // Private method?
  inflateCards(cards) {
    return cards.map(card => new Card(card.rank, card.suit))
  }

  name() {
    return this._name
  }

  cardAmount() {
    return this._cardAmount
  }
}

export default Bot
