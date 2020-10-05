class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :follows, :change_pw, :send_change_pw]
  before_action :check_login, only: [:edit, :update, :change_pw, :send_change_pw]
  before_action :check_changing_pw, only: [:send_change_pw]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /register
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Successful registration!'
      redirect_to auth_path
    else
      render :new
    end
  end

  # GET /users/:id/edit
  def edit
  end

  # POST /users/:id/update
  def update
    if @user.update(user_params)
      flash[:notice] = "Updating your profile successful!"
      redirect_back fallback_location: events_path
    else
      render :edit
    end
  end

  # GET /users/:id
  def show
  end

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id/follows
  def follows
  end

  # GET /forgotten
  def forgotten
  end

  # POST /send_forgotten
  def send_forgotten
    @user = User.where(email: params[:email]).take
    unless @user
      flash[:notice] = "No user registered under this email."
      render :forgotten
    else
      pass = @user.randomize_password
      @user.save
      flash[:notice] = "Your new password is:\n#{pass}"
      redirect_to auth_path
    end
  end

  # GET /users/:id/change_pw
  def change_pw
  end

  # PUT /users/:id/send_change_pw
  def send_change_pw
    @user.password = params[:user][:password]
    if @user.save
      flash[:notice] = 'Successful change of password'
      render :show
    else
      render :change_pw
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Checking and redirecting if not logged in already
    def check_login
      unless session[:user] == params[:id].to_i
        flash[:notice] = "You must be logged in to access this section!"
        redirect_to auth_path
      end
    end

    # Checking if the given old_password is the same as current password
    def check_changing_pw
      if !@user.authenticated?(params[:user][:old_password])
        flash[:notice] = "Wrong old password!"
        redirect_to change_pw_path
      elsif params[:user][:password] != params[:user][:password_confirmation]
        flash[:notice] = "New password not matching confirmation!"
        redirect_to change_pw_path
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
        :name, :city, :profile, :about, :public)
    end
end
