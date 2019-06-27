import React from 'react';
import PropTypes from 'prop-types';
import CardView from './CardView'

class EndView extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      stats: [],
    }
  }

  componentDidMount() {
    this.fetchStats()
  }

  fetchStats(id) {
    fetch(`/games/${this.props.id}/stats.json`, {
      credentials: 'same-origin',
    }).then(response => response.json())
      .then((data) => {
        this.setState({
          stats: data,
        })
      })
  }

  renderRankings() {
    return this.state.stats.map((stat, index) => {
      return (<h3 key={index}>{stat[0]} had {stat[1]} point(s)</h3>)
    })
  }

  render() {
    return (
      <div>
        <h1><u>Game Over</u></h1>
        <h1>Rankings:</h1>
        {this.renderRankings()}
      </div>
    )
  }
}

EndView.propTypes = {
  id: PropTypes.number.isRequired,
}

export default EndView
