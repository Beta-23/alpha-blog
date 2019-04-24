ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # Add more helper methods to be used by all tests here...
  def sign_in_as(user, password)
    post login_path, params: { session: { email: user.email, password: password }}
  end
  
  def current_user
    # Return user object if session hash is present on browser, if not find user find user in database via user_id. 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # Boolean statement-“predicate methods”--> returns true or false if user is logged in
    !!current_user 
  end
end
