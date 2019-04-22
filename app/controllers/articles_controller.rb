class ArticlesController < ApplicationController
  #this action calls the set_article & require_user method for only edit, update, show, destroy actions
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  #this action calls the require_user method except, index and show need loggedin user for all other actions
  before_action :require_user, except: [:index, :show]
  
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
   #this method captures all articles created
  def index
   @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  #this method creates new article array
  def new
    @article = Article.new
  end
  
  #this method finds article by params id to edit
  def edit
  end
  
  #this method creates new article from params; checks for current_user and creates flash msg and redirect or renders
  def create
    @article = Article.new(article_params)
    #set current user to be the creator of article 
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created succesfully!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  #this method udates article via edit route (resources :articles); creates flash msg and redirect or renders
  def update
    if @article.update(article_params)
      flash[:success] = "Article was succesfully updated!"
      redirect_to article_path(@article)
    else
      render 'edit'
      
    end
  end
  
  #this method show articles from params by id via call action set_article
  def show
    
    
  end
  
  #this method delete's articles from params by id via call action set_article
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted!"
    redirect_to articles_path
  end
  
  private
  #This method get's call in the before_action for only edit, show, update and destroy methods
  def set_article
    @article = Article.find(params[:id])
  end
  
  #this method grabs article params
    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end
    
    #method prevents other users from edit, destroy other users articles, checks in the before_action
    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only update your own articles!"
        redirect_to root_path
      end
    end
end