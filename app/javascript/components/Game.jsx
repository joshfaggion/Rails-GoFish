import React from 'react';
import PropTypes from 'prop-types';
import Player from '../models/player'
import PlayerView from './PlayerView'
import BotView from './BotView'
import Bot from '../models/Bot'
import CardBack from '../img/backs_blue.png'

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentPlayer: new Player(this.props.playerData.player),
      opponents: this.props.playerData.opponents.map(opponent => new Bot(opponent)),
      selectedPlayer: '',
      selectedRank: '',
    }
  }

  updateGame() {
    this.fetchGame(this.props.id)
  }

  updateSelectedRank(rank) {
    this.setState({ selectedRank: rank })
  }

  updateSelectedPlayer(player) {
    this.setState({ selectedPlayer: player })
  }

  fetchGame(id) {
    fetch(`/games/${id}.json`).then(response => response.json())
      .then(this.handleData.bind(this))
      .catch(err => console.error(err)) // eslint-disable-line no-console
  }

  handleData(data) {
    console.log(data) // eslint-disable-line no-console
    this.setState(() => ({
      currentPlayer: data.player,
      opponents: data.opponents,
    }))
  }

  middleOfDeck() {
    if (this.props.playerData.deck_amount === 0) return null
    return (
      <div>
        <img alt="The middle of the deck" src={CardBack} />
      </div>
    )
  }

  render() {
    return (
      <div>
        <h1>Game {this.props.id} - in progress</h1>
        <div>
          {this.state.opponents.map(bot => <BotView updateSelectedPlayer={this.updateSelectedPlayer.bind(this)} selectedPlayer={this.state.selectedPlayer} key={bot.name()} bot={bot} />)}
        </div>
        <h3> Deck: </h3>
        {this.middleOfDeck()}
        <PlayerView selectedRank={this.state.selectedRank} player={this.state.currentPlayer} />
      </div>
    )
  }
}

Game.propTypes = {
  id: PropTypes.number.isRequired,
  playerData: PropTypes.object.isRequired,
}

export default Game;
