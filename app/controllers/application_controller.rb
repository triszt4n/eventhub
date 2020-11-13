class ApplicationController < ActionController::Base
  helper_method :current_controller?
  before_action :find_user
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

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
    def render_not_found
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end

    def render_forbidden
      render layout: "layouts/application", template: "layouts/_hidden", status: :forbidden
    end
end
