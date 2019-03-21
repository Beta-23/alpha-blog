class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # helper methods that are available to the views
  helper_method :current_user, :logged_in?
  
  def current_user
    # Return user object if session hash is present on browser, if not find user find user in database via user_id. 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # Boolean statement-“predicate methods”--> returns true or false if user is logged in
    !!current_user 
  end
  
  def require_user
    # Restrict actions of user depending if they are logged in or not
    if !logged_in?
      flash[:danger] = "You must login to perform this action"
      redirect_to root_path
    end
  end
end
