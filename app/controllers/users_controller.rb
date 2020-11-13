class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :change_pw, :send_change_pw, :follow]
  before_action :set_user_show, only: [:show]
  before_action :set_user_follows, only: [:follows]
  before_action :check_login, only: [:follow, :edit, :update, :change_pw, :send_change_pw]
  before_action :check_permission, only: [:edit, :update, :change_pw, :send_change_pw]
  before_action :check_changing_pw, only: [:send_change_pw]
  before_action :check_self_follow, only: [:follow]
  before_action :check_public, only: [:show, :follows, :follow]

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
      flash[:notice] = "Updated your profile successfully!"
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
    @users = User.includes(:events, :followers).where(public: true).all
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

  # POST /users/:id/follow
  def follow
    if helpers.am_i_following_user?
      UserFollow.find_by(follower: @current_user, followee: @user).destroy
    else
      UserFollow.create(follower: @current_user, followee: @user)
    end
    redirect_back fallback_location: @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_user_show
      @user = User.includes(:events, :followers => :followers).find(params[:id])
    end

    def set_user_follows
      @user = User.includes(:followed_events, :followees => :followers).find(params[:id])
    end

    # Check if the original user made the request
    def check_permission
      unless helpers.is_it_me?
        flash[:notice] = "You are not permitted to make changes, log in!"
        redirect_to auth_path
      end
    end

    # Check if the user is logged in sending request
    def check_login
      unless helpers.logged_in?
        flash[:notice] = "You need to log in first!"
        redirect_to auth_path
      end
    end

    # Check if the user want to follow theirselves
    def check_self_follow
      if helpers.is_it_me?
        flash[:notice] = "You can't follow yourself!"
        redirect_to @user
      end
    end

    # Check if the given old_password is the same as current password
    def check_changing_pw
      if !@user.authenticated?(params[:user][:old_password])
        flash[:notice] = "Wrong old password!"
        redirect_to change_pw_path
      elsif params[:user][:password] != params[:user][:password_confirmation]
        flash[:notice] = "New password not matching confirmation!"
        redirect_to change_pw_path
      end
    end

    # Check if user wants to share their profile
    def check_public
      if !@user.public && !helpers.is_it_me?
        render_hidden
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
        :name, :city, :profile, :about, :public)
    end
end
