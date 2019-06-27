class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @game = Game.new
  end

  def index
    @pending_games = Game.pending
  end

  def create
    @game = Game.create(game_params)
    current_user = User.find(session[:current_user]['id'])
    if @game.save
      @game.users << current_user
      redirect_to @game, notice: 'Game created'
    else
      render :create
    end
  end

  def join
    game = Game.find params[:format]
    current_user = User.find(session[:current_user]['id'])
    unless game.users.include?(current_user)
      game.users << current_user
    end
    if game.users.length == game['player_count']
      game.start
    end
    redirect_to game
  end

  def play_round
    game = Game.find params[:id]
    current_user = User.find(session[:current_user]['id'])
    game.play_round(current_user.name, params['requestedPlayer'], params['requestedRank'])
    pusher_notification
  end

  def show
    @game = Game.find params[:id]
    current_user = User.find(session[:current_user]['id'])
    respond_to do |format|
      format.html
      format.json { render :json => @game.go_fish.state_for(current_user.name) }
    end
  end

  def state

  end

  private

  def pusher_notification
    pusher_client.trigger('go-fish', 'game-changed', {
      message: "Somebody took turn"
    })
  end

  def game_params
    params.require(:game).permit(:player_count)
  end
end
