class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def index
    @pending_games = Game.pending
  end

  def create
    @game = Game.find_or_initialize_by(game_params)
    @game.users << User.find(session[:current_user]['id'])
    if @game.save
      redirect_to @game, notice: 'Game created'
    else
      render :create
    end
  end

  def show
    @game = Game.find params[:id]
  end

  def join
    @game = Game.find params[:id]
    redirect_to @game
  end

  private

  def game_params
    params.require(:game).permit(:player_count)
  end
end
