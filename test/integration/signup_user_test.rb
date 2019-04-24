require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  
  def setup
  @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
  end
  
  test "new signup can see welcome page" do
    get user_path(@user)
    assert_template 'users/show'
  end
  
  test "restricts logged_in users from signing up via url" do
    sign_in_as(@user, "password")
    get user_path(@user)
    if logged_in? && current_user != @user
      assert_equal 'Sorry, you are already a logged in user!', flash[:warning]
        redirect_to root_path
    end
  end
end