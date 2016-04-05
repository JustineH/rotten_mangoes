class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def admin_restrict_access
    if !current_user.admin?
      flash[:alert] = "You do not have permission to access this page."
      redirect_to movies_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user && (current_user.admin? || impersonating?)
  end

  def impersonating?
    if session[:actual_user_id].present?
      user = User.find(session[:actual_user_id])
      user.admin?
    else
      false
    end
  end

  helper_method :current_user, :admin?, :impersonating?
  
end
