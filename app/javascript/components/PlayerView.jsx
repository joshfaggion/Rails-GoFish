import React from 'react';
import PropTypes from 'prop-types';

class PlayerView extends React.Component {
  hello() {
    console.log('hello')
  }

  render() {
    return (
      <h1> Hi, my name is {this.props.player.state.name} </h1>
    )
  }
}

PlayerView.propTypes = {
  player: PropTypes.object.isRequired
}

export default PlayerView
