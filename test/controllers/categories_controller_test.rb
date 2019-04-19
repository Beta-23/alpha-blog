require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
   def setup
     @category = Category.create(name: "sports")
     @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
   end
   
   test "should get catergory index" do
     get categories_path
     assert_response :success
    
   end
  
    test "should get new" do
      sign_in_as(@user, "password")
      get new_category_path
      assert_response :success
    end
    
    test "should get show" do
      get category_path(@category)
      assert_response :success
    end
    
    test "redirect if not logged in admin" do 
      assert_no_difference 'Category.count' do
        post categories_path, params: { category:{ name:"sports" } }
      end
      assert_redirected_to categories_path
    end
end