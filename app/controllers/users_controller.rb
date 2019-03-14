class UsersController < ApplicationController
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha_Blog #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated successfully!"
      redirect_to articles_path
      
      else
        render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    # instance variable of all the users articles by using pagination
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  
  end
  
  
end