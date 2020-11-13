class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy, :follow]
  before_action :set_event_with_includes, only: [:show]
  before_action :check_login, only: [:follow, :edit, :update, :destroy]
  before_action :check_self_follow, only: [:follow]
  before_action :check_permission, only: [:edit, :update, :destroy]
  before_action :check_published, only: [:show, :follow]

  # GET /events
  def index
    @events = Event.includes(:user).where(published: true).order(created_at: :desc).all
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.user = @current_user

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  # PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.posts.destroy_all
    @event.event_follows.destroy_all
    @event.destroy
    redirect_to events_url
  end

  # POST /events/1/follow
  def follow
    if helpers.am_i_following_event?
      EventFollow.find_by(event: @event, user: @current_user).destroy
    else
      EventFollow.create(event: @event, user: @current_user)
    end
    redirect_to @event
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_event_with_includes
      @event = Event.includes(:user, :posts, :users => :followers).find(params[:id])
    end

    # Check if the owner wants to follow their own event
    def check_self_follow
      if helpers.am_i_owner?
        flash[:notice] = "You can't follow your own event!"
        redirect_to @event
      end
    end

    # Check if the user is logged in sending request
    def check_login
      unless helpers.logged_in?
        flash[:notice] = "You need to log in first!"
        redirect_to auth_path
      end
    end

    # Check if the owner sent this request
    def check_permission
      unless helpers.am_i_owner?
        flash[:notice] = "You are not permitted to make changes!"
        redirect_to @event
      end
    end

    # Check if the event is set to published
    def check_published
      if !@event.published && !helpers.am_i_owner?
        render_forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :theme, :short_desc, :full_desc, :published, :start_date, :end_date, :place)
    end
end
