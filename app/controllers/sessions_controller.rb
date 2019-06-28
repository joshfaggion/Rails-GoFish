class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(user_params)
    if @user.save
      login @user
      redirect_to games_path, notice: 'Logged in'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
