class ApplicationController < ActionController::Base
  def current_controller?(names)
    names.include?(params[:controller]) unless params[:controller].blank? || false
  end

  helper_method :current_controller?

  before_action :find_user

  private
    def find_user
      if session[:user]
        @user = User.find session[:user]
      end
    end
end
