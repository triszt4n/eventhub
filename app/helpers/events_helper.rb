module EventsHelper
  def am_i_following_event?
    @event.users.include? @current_user
  end

  def am_i_following_owner?
    @event.user.followers.include? @current_user
  end

  def am_i_owner?
    session[:user] == @event.user.id
  end
end
