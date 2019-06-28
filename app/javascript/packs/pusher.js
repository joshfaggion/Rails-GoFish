import Pusher from 'pusher-js'


const pusher = new Pusher('d0f473c4ba0b5ebf8a02', {
  cluster: 'us2',
  forceTLS: true,
});

const channel = pusher.subscribe('go-fish');
channel.bind('lobby-updated', (data) => {
  if (data.playerid !== document.body.dataset.current_user_id) {
    if (window.location.pathname === `/games/${data.gameid}` || window.location.pathname === '/games') {
      window.location.reload()
    }
  }
})

channel.bind('game-created', (data) => {
  if (data.playerid !== document.body.dataset.current_user_id) {
    if (window.location.pathname === '/games') {
      window.location.reload()
    }
  }
})
