class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :change_pw]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /register
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      flash[:notice] = "You've logged in."
      redirect_back fallback_location: auth_path
    else
      flash[:notice] = @user.errors.messages
      redirect_back fallback_location: auth_path
    end
  end

  # GET /users/:id/edit
  def edit
    unless session[:user] == @user.id
      flash[:notice] = "You have no permission to edit this profile!"
      redirect_to events_path
    end
  end

  # POST /users/:id/update
  def update
    if session[:user] == @user.id
      if @user.update(user_params)
        redirect_back fallback_location: events_path
      else
        flash[:notice] = "Couldn't edit your profile!"
        redirect_back fallback_location: events_path
      end
    else
      flash[:notice] = "You have no permission to edit this profile!"
      redirect_to events_path
    end
  end

  # GET /users/:id
  def show
  end

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/forgotten
  def forgotten
  end

  # POST /users/send_forgotten
  def send_forgotten
    @user = User.find_by(params[:user][:email])
    pass = @user.random_password
    # instead of emailing password:
    flash[:notice] = "Your new password:\n#{pass}"
    redirect_back fallback_location: auth_path
  end

  # GET /users/:id/change_pw
  def change_pw
    unless session[:user] == @user.id
      flash[:notice] = "You have no permission to edit this profile!"
      redirect_to events_path
    end
  end

  # PUT /users/:id/send_change_pw
  def send_change_pw
    if session[:user] == @user.id
      if @user.update(user_params)
        redirect_back fallback_location: events_path
      else
        flash[:notice] = "Couldn't change password!"
        redirect_back fallback_location: events_path
      end
    else
      flash[:notice] = "You have no permission to edit this profile!"
      redirect_to events_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :city, :profile, :about, :public)
    end
end
