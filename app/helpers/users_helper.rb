module UsersHelper
  def am_i_following_user?
    @user.followers.include? @current_user
  end

  def is_it_me?
    @user.id == session[:user]
  end
end
