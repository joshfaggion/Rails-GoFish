import React from 'react';
import PropTypes from 'prop-types';
import Player from '../models/player'
import PlayerView from './PlayerView'
import BotView from './BotView'
import Bot from '../models/Bot'

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentPlayer: new Player(this.props.playerData.player),
      opponents: this.props.playerData.opponents.map(opponent => new Bot(opponent)),
    }
  }

  updateGame() {
    this.fetchGame(this.props.id)
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

  render() {
    return (
      <div>
        <h1>Game {this.props.id} - in progress</h1>
        {this.state.opponents.map(bot => <BotView key={bot.name()} bot={bot} />)}
        <PlayerView player={this.state.currentPlayer} />
      </div>
    )
  }
}

Game.propTypes = {
  id: PropTypes.number.isRequired,
  playerData: PropTypes.object.isRequired,
}

export default Game;
