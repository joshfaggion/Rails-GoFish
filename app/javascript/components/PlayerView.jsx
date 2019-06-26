import React from 'react';
import PropTypes from 'prop-types';
import CardView from './CardView'

class PlayerView extends React.Component {
  hello() {
    return 2 + 2
  }

  render() {
    return (
      <div>
        <h3><u>{this.props.player.name()}</u></h3>
        {this.props.player.cards().map(card => <CardView isTurn={this.props.isTurn} class="player-card" updateSelectedRank={this.props.updateSelectedRank} selectedRank={this.props.selectedRank} key={card.value()} card={card} />)}
        <div>
          {this.props.player.matches().map(card => <CardView isTurn={this.props.isTurn} class="match" updateSelectedRank={() => {}} selectedRank={this.props.selectedRank} key={card.value()} card={card} />)}
        </div>
      </div>
    )
  }
}

PlayerView.propTypes = {
  player: PropTypes.object.isRequired,
  selectedRank: PropTypes.string.isRequired,
  updateSelectedRank: PropTypes.func.isRequired,
  isTurn: PropTypes.string.isRequired,
}

export default PlayerView
