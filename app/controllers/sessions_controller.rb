class SessionsController < ApplicationController
  # POST /sessions/create
  def create
  end

  # DELETE /sessions/destroy
  def destroy
  end

  # GET /auth - login screen
  def auth
    @user = User.new
  end
end
