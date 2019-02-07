class ArticlesController < ApplicationController
  #this action calls the set_article method for only edit, update, show, destroy actions
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
   #this method captures all articles created
  def index
   @articles = Article.all 
  end
  
  #this method creates new article array
  def new
    @article = Article.new
  end
  
  #this method finds article by params id to edit
  def edit
  end
  
  #this method creates new article from params; creates flash msg and redirect or renders
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created succesfully!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  #this method udates article via edit route (resources :articles); creates flash msg and redirect or renders
  def update
    if @article.update(article_params)
      flash[:notice] = "Article was succesfully updated!"
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
    flash[:notice] = "Article was successfully deleted!"
    redirect_to articles_path
  end
  
  private
  #This method get's call in the before_action for only edit, show, update and destroy methods
  def set_article
    @article = Article.find(params[:id])
  end
  
  #this method grabs article params
    def article_params
      params.require(:article).permit(:title, :description)
    end
end