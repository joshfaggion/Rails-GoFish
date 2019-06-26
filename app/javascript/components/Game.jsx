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
      currentPlayer: new Player(props.playerData.player),
      opponents: props.playerData.opponents.map(opponent => new Bot(opponent)),
      selectedPlayer: '',
      selectedRank: '',
      isTurn: props.playerData.is_turn,
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
    this.setState({
      currentPlayer: new Player(data.player),
      opponents: data.opponents.map(opponent => new Bot(opponent)),
      selectedPlayer: '',
      selectedRank: '',
      isTurn: data.is_turn,
    })
  }

  middleOfDeck() {
    if (this.props.playerData.deck_amount === 0) return null
    return (
      <div>
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
    }).then(response => response.json())
      .then(response => this.handleData(response))
      .catch(err => console.error(err)) // eslint-disable-line no-console
  }

  renderHeader() {
    if (this.state.isTurn === 'true') {
      return <h2>It's your turn, make your request.</h2>
    }
    return <h2>It's someone else's turn, so be patient.</h2>
  }

  renderRequestButton() {
    if (this.state.selectedRank !== '' && this.state.selectedPlayer !== '') {
      return <button className="request-button" onClick={this.submitCard.bind(this)} type="submit">Request Card</button>
    }
    return ''
  }

  renderRefreshStateButton() {
    return <button type="button" onClick={this.updateGame.bind(this)}>Refresh State</button>
  }

  render() {
    return (
      <div>
        <h1>Game {this.props.id} - in progress</h1>
        {this.renderHeader()}
        <div>
          {this.state.opponents.map(bot => <BotView isTurn={this.state.isTurn} updateSelectedPlayer={this.updateSelectedPlayer.bind(this)} selectedPlayer={this.state.selectedPlayer} key={bot.name()} bot={bot} />)}
        </div>
        <h3> Deck: </h3>
        {this.middleOfDeck()}
        <PlayerView isTurn={this.state.isTurn} updateSelectedRank={this.updateSelectedRank.bind(this)} selectedRank={this.state.selectedRank} player={this.state.currentPlayer} />
        {this.renderRequestButton()}
        {this.renderRefreshStateButton()}
      </div>
    )
  }
}

Game.propTypes = {
  id: PropTypes.number.isRequired,
  playerData: PropTypes.object.isRequired,
}

export default Game;
