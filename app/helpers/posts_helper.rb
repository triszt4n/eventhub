module PostsHelper
  def am_i_poster?
    @post.event.user.id == session[:user]
  end
end
