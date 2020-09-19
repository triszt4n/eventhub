class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :change_pw]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /register
  def create
  end

  # GET /users/:id/edit
  def edit
    @user = User.new(id: 1, email: "asd@asd.com", name: "Wolfgang Amadeus Mozart", city: "Salzburg, AT", profile: "Classical music", 
      about: "Lorem ipsum dolor sic amet", public: true)
  end

  # POST /users/:id/update
  def update
  end

  # GET /users/:id
  def show
    @user = User.new(id: 1, email: "asd@asd.com", name: "Wolfgang Amadeus Mozart", city: "Salzburg, AT", profile: "Classical music", 
      about: "Lorem ipsum dolor sic amet", public: true)
  end

  # GET /users
  def index
    # @users = User.all
    @users = []
    @users << User.new(id: 1, email: "fgh@asd.com", name: "Ludwig van Beethoven", city: "Bonn, DE", profile: "Classical music", 
      about: "Lorem ipsum dolor sic amet", public: true)
    @users << User.new(id: 2, email: "asd@asd.com", name: "Wolfgang Amadeus Mozart", city: "Salzburg, AT", profile: "Classical music", 
      about: "Lorem ipsum dolor sic amet", public: true)
  end

  # GET /users/forgotten
  def forgotten
  end

  # POST /users/send_forgotten
  def send_forgotten
  end

  # GET /users/:id/change_pw
  def change_pw
  end

  # PUT /users/:id/send_change_pw
  def send_change_pw
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :city, :profile, :about, :public)
    end
end
