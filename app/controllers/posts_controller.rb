class PostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts/1
  def show
    @post = Post.new id: 1, title: "Hello everybody", body: "Welcome here, we'll stay in touch via these post under the event. Thanks!", event_id: 1, created_at: DateTime.new(2020,1,10,10,30,0)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.new id: 1, title: "Hello everybody", body: "Welcome here, we'll stay in touch via these post under the event. Thanks!", event_id: 1
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
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
    @post.destroy
    redirect_to posts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_post
    #   @post = Post.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :event_id)
    end
end
