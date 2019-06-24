import React from 'react';
import PropTypes from 'prop-types';
import Player from '../models/player'
import PlayerView from './PlayerView'

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentPlayer: new Player(this.props.initialState['player']),
      opponents: this.props.initialState['opponents'],
    }
  }

  updateGame() {
    this.fetchGame(this.props.id)
  }

  fetchGame(id) {
    fetch(`/games/${id}.json`).then(response => response.json())
      .then(this.handleData.bind(this))
      .catch(err => console.log(err)) // eslint-disable-line no-console
  }

  handleData(data) {
    console.log(data) // eslint-disable-line no-console
    this.setState(() => ({
      currentPlayer: data['player'],
      opponents: data['opponents'],
    }))
  }

  render() {
    return (
      <div>
        <h1>Game {this.props.id} - in progress</h1>
        <PlayerView player={this.state.currentPlayer} />
      </div>
    )
  }
}

Game.propTypes = {
  id: PropTypes.number.isRequired,
  initialState: PropTypes.object.isRequired,
  playerName: PropTypes.string.isRequired
}

export default Game;
