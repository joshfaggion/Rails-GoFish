class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @game = Game.new
  end

  def index
    @user = User.find(session[:current_user]['id'])
    @pending_games = Game.pending
    @in_progress_games = Game.in_progress.select { |game| game.users.include?(@user) }
    @finished_games = Game.finished.select { |game| game.users.include?(@user) }
  end

  def instructions
  end

  def fill_with_robots
    game = Game.find params[:id]
    current_user = User.find(session[:current_user]['id'])
    game.autofill
    game.start
    lobby_pusher_notification(game.id)
    redirect_to game
  end

  def create
    @game = Game.create(game_params)
    current_user = User.find(session[:current_user]['id'])
    if @game.save
      @game.users << current_user
      new_game_pusher_notification()
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
    lobby_pusher_notification(game.id)
    redirect_to game
  end

  def leave
    game = Game.find params[:format]
    current_user = User.find(session[:current_user]['id'])
    GameUser.find_by(user: current_user, game_id: game.id).destroy
    if game.users.none?
      game.destroy
    end
    lobby_pusher_notification(game.id)
    redirect_to games_path
  end

  def play_round
    game = Game.find params[:id]
    current_user = User.find(session[:current_user]['id'])
    game.play_round(current_user.name, params['requestedPlayer'], params['requestedRank'])
    game_pusher_notification
  end

  def stats
    game = Game.find params[:id]
    game.stats
    game.finish
    render :json => game.stats
  end

  def show
    @game = Game.find params[:id]
    current_user = User.find(session[:current_user]['id'])
    respond_to do |format|
      format.html
      format.json { render :json => @game.go_fish.state_for(current_user.name) }
    end
  end

  private

  def lobby_pusher_notification(game_id)
    pusher_client.trigger('go-fish', 'lobby-updated', {
      playerid: "#{session[:current_user]['id']}",
      gameid: "#{game_id}"
    })
  end

  def new_game_pusher_notification
    pusher_client.trigger('go-fish', 'game-created', {
      playerid: "#{session[:current_user]['id']}"
    })
  end

  def game_pusher_notification
    pusher_client.trigger('go-fish', 'game-changed', {
      message: "Somebody took turn"
    })
  end

  def game_params
    params.require(:game).permit(:player_count)
  end
end
