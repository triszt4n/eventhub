class SessionsController < ApplicationController
  # POST /sessions/create
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user] = @user.id
      redirect_to events_path
    else
      flash[:notice] = "No match in database with these credentials"
      redirect_to auth_path
    end
  end

  # DELETE /sessions/destroy
  def destroy
    reset_session
    flash[:notice] = 'Logged out sucessfully'
    redirect_to events_path
  end

  # GET /auth - login screen
  def auth
  end
end
