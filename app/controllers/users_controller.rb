class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  before_action :require_signup, only: [:new]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha_Blog #{@user.username}!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user = User.find(params[:id])
      flash[:success] = "Profile updated successfully!"
      redirect_to articles_path
    else
        render 'edit'
    end
  end
  
  def show
    # instance variable of all the users articles by using pagination
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted!"
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    #instance variable that finds user by id and has ready for the before_action :set_user edit, update and show
    @user = User.find(params[:id])
  end
  
  def require_same_user
      if !logged_in? || (current_user != @user && !current_user.admin?)
        flash[:danger] = "You can only update when logged into your own account!"
        redirect_to root_path
      end
  end
  
  #method ensures users are not able to signup if currently logged in, called by the before action
  def require_signup
    if logged_in? && current_user != @user
        flash[:warning] = "Sorry, you are already a logged in user!"
        redirect_to root_path
    end  
  end
  
  def require_admin
    if !logged_in? && !current_user.admin?
        flash[:warning] = "Only admin can perform this action!"
        redirect_to root_path
    end    
  end
end