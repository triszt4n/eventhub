class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:new, :create]
  before_action :check_permission, only: [:edit, :update, :destroy]
  before_action :check_published, only: [:show]

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.event = @event

    if @post.save
      redirect_to @post.event
    else
      render :new
    end
  end

  # PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    event = @post.event
    @post.destroy
    redirect_to event
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_event
      @event = Event.find params[:event_id]
      unless helpers.am_i_owner?
        flash[:notice] = "You have no permission to make changes!"
        redirect_to @event
      end
    end

    # Check if the owner sent the request
    def check_permission
      unless helpers.am_i_poster?
        flash[:notice] = "You have no permission to make changes!"
        redirect_to @post
      end
    end

    # Check if the owner event is set to published
    def check_published
      if !@post.event.published && !helpers.am_i_poster?
        render_forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :event_id)
    end
end
