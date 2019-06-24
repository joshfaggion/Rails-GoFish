import React from 'react';
import PropTypes from 'prop-types';


class Game extends React.Component {
  componentDidMount() {
    this.handleData(this.props.initialState)
  }

  updateGame() {
    this.fetchGame(this.props.id)
  }

  fetchGame(id) {
    fetch(`/games/${id}.json`).then(response => response.json())
      .then(this.handleData.bind(this))
      .catch(err => console.log(err))
  }

  handleData(data) {
    console.log(data)
    this.setState(() => ({
      currentPlayer: data['player'],
      opponents: data['opponents'],
    }))
  }

  render() {
    return (
      <div>
        <h3>
          This player is {this.props.playerName}
        </h3>
      </div>
    )
  }
}

Game.propTypes = {
  id: PropTypes.number.isRequired,
  playerName: PropTypes.string.isRequired,
  initialState: PropTypes.object.isRequired,
}

export default Game;
