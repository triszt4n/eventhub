class ApplicationController < ActionController::Base
  helper_method :current_controller?
  before_action :find_user
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def current_controller?(names)
    names.include?(params[:controller]) unless params[:controller].blank? || false
  end

  private
    def find_user
      if session[:user]
        @current_user = User.find session[:user]
      end
    end
  
  protected
    def render_404
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end

    def render_401
      render :file => "#{Rails.root}/public/401.html", :status => 401
    end
end
