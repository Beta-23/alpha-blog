class SessionsController < ApplicationController
  
  def new
  
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #session hash that will be remembered by the browser cookies
      session[:user_id] = user.id
      flash[:success] = "horay! you have logged in successfully"
      redirect_to user_path(user)
    
    else
      
      flash.now[:danger] = "There's an error with your login information"
      
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "See you soon! You are logged out"
    redirect_to articles_path
    
  end
  
end