import React from 'react';
import PropTypes from 'prop-types'
import Pusher from 'pusher-js'
import Player from '../models/player'
import PlayerView from './PlayerView'
import BotView from './BotView'
import Bot from '../models/Bot'
import CardBack from '../img/backs_blue.png'
import EndView from './EndView'

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentPlayer: new Player(props.playerData.player),
      opponents: props.playerData.opponents.map(opponent => new Bot(opponent)),
      selectedPlayer: '',
      selectedRank: '',
      isTurn: props.playerData.is_turn,
      deckAmount: props.playerData.deck_amount,
      gameActive: props.playerData.game_active,
      log: Array.from(props.playerData.log),
      requestingPlayer: props.playerData.requesting_player,
    }
  }

  componentDidMount() {
    Pusher.logToConsole = false;

    const pusher = new Pusher('d0f473c4ba0b5ebf8a02', {
      cluster: 'us2',
      forceTLS: true,
    });

    const channel = pusher.subscribe('go-fish')
    // Use game id to make this unique
    channel.bind('game-changed', (data) => {
      this.updateGame()
    })
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
    fetch(`/games/${id}.json`, {
      credentials: 'same-origin',
    }).then(response => response.json())
      .then(this.handleData.bind(this))
      .catch(err => console.error(err)) // eslint-disable-line no-console
  }

  handleData(data) {
    this.setState({
      currentPlayer: new Player(data.player),
      opponents: data.opponents.map(opponent => new Bot(opponent)),
      selectedPlayer: '',
      selectedRank: '',
      isTurn: data.is_turn,
      deckAmount: data.deck_amount,
      gameActive: data.game_active,
      log: Array.from(data.log),
      requestingPlayer: data.requesting_player,
    })
  }

  middleOfDeck() {
    if (this.state.deckAmount === 0) return null
    return (
      <div className="centered-wrapper">
        <h3>Deck:</h3>
        <img alt="The middle of the deck" src={CardBack} />
      </div>
    )
  }

  submitCard() {
    fetch(`/games/${this.props.id}/play_round.json`, {
      method: 'PATCH',
      body: JSON.stringify({
        requestedPlayer: this.state.selectedPlayer,
        requestedRank: this.state.selectedRank,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
      credentials: 'same-origin',
    })
      .catch(err => console.error(err)) // eslint-disable-line no-console
  }

  renderHeader() {
    if (this.state.isTurn === 'true') {
      return <h2 className="centered">It's your turn.</h2>
    }
    return <h2 className="centered">Waiting for {this.state.requestingPlayer} to make their move...</h2>
  }

  renderRequestButton() {
    if (this.state.selectedRank !== '' && this.state.selectedPlayer !== '') {
      return <div className="centered-wrapper"><button className="request-button" onClick={this.submitCard.bind(this)} type="submit">Request Card</button></div>
    }
    return ''
  }

  renderRefreshStateButton() {
    // For testing purposes
    return <button type="button" onClick={this.updateGame.bind(this)}>Refresh State</button>
  }

  renderGameLog() {
    return (
      <div className="game-log">
        <h4>Game Log: (top is newest)</h4>
        {this.state.log.map((result, index) => <h5 key={index}>{result}</h5>)}
      </div>
    )
  }

  renderActiveGame() {
    return (
      <div>
        <h1 className="centered">Game {this.props.id} - in progress</h1>
        {this.renderHeader()}
        <div className="bots">
          {this.state.opponents.map(bot => <BotView isTurn={this.state.isTurn} updateSelectedPlayer={this.updateSelectedPlayer.bind(this)} selectedPlayer={this.state.selectedPlayer} key={bot.name()} bot={bot} />)}
        </div>
        {this.middleOfDeck()}
        <PlayerView isTurn={this.state.isTurn} updateSelectedRank={this.updateSelectedRank.bind(this)} selectedRank={this.state.selectedRank} player={this.state.currentPlayer} />
        {this.renderRequestButton()}
        {this.renderGameLog()}
      </div>
    )
  }

  renderEndGame() {
    return <EndView id={this.props.id} />
  }

  render() {
    if (this.state.gameActive === 'true') {
      return this.renderActiveGame()
    }
    return this.renderEndGame()
  }
}

Game.propTypes = {
  id: PropTypes.number.isRequired,
  playerData: PropTypes.object.isRequired,
}

export default Game;
