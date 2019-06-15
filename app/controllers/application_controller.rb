class ApplicationController < ActionController::Base


  helper_method(:current_user, :logged_in?, :is_admin?)

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin?
    return !!(logged_in?() && current_user().admin?)
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if (!logged_in?)
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path
    end
  end

  def require_admin
    if (!logged_in? || !current_user.admin?)
      flash[:danger] = "Only Admins can commit this action"
      redirect_to categories_path
    end
  end
end
