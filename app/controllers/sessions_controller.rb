class SessionsController < ApplicationController
  # POST /sessions/create
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user] = @user.id
      redirect_back fallback_location: events_path
    else
      flash[:notice] = "Not match in database with these credentials!"
      redirect_back fallback_location: events_path
    end
  end

  # DELETE /sessions/destroy
  def destroy
    reset_session
    flash[:notice] = "You've logged out."
    redirect_to events_path
  end

  # GET /auth - login screen
  def auth
    if session[:user] 
      @user = User.new
    else
      flash[:notice] = "You've already logged in."
      redirect_to events_path
    end
  end
end
