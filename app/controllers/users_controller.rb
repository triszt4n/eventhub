class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :change_pw]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
  end

  # GET /users/:id/edit
  def edit
  end

  # POST /users/:id/update
  def update
  end

  # GET /users/:id
  def show
    @user = User.first
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
  end

  # GET /auth - login screen
  def auth
    @user = User.new
  end

  # GET /users/:id/change_pw
  def change_pw
  end

  # PUT /users/:id/send_change_pw
  def send_change_pw
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :city, :profile, :about, :public)
    end
end
