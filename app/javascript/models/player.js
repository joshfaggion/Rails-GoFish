class Player {
  constructor(props) {
    this.state = {
      is_turn: props['is_turn'],
      name: props['name']
    }
  }
}

export default Player
