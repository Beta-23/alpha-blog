require 'test_helper'

class NewArticleTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
  end
  
  test "get new article form and create new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
    post articles_path, params: { article: { title:  "Article Title", description: "IntegrationTest.", user_id: 1 } }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_equal 'Article was created succesfully!', flash[:success]
  end
  
  test "testing validations of new articles title" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference "Article.count" do
      post articles_path, params: { article:{ title: " ", description: "This description is long enough!" }}
    end
    assert_template 'articles/new'
    assert_select "h2.panel-title"
    assert_match "2 errors", response.body
    assert_match "prohibited this from being saved:", response.body
    assert_match "Title is too short (minimum is 3 characters)", response.body
  end
  
  test "testing validations of new articles description" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference "Article.count" do
      post articles_path, params: { article:{ title: "Article Title", description: "aaaa" }}
    end
    assert_template 'articles/new'
    assert_select "h2.panel-title"
    assert_match "1 error", response.body
    assert_match "prohibited this from being saved:", response.body
    assert_match "Description is too short (minimum is 10 characters)", response.body
  end
end 


  