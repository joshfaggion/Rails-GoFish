require 'pusher'

class ApplicationController < ActionController::Base

  def pusher_client
    @pusher_client ||= Pusher::Client.new(
      app_id: '812126',
      key: 'd0f473c4ba0b5ebf8a02',
      secret: '4ea091a40255041a6255',
      cluster: 'us2',
      encrypted: true
    )
  end

  def login(user)
    session[:current_user] = user
  end
end
