class ArticlesController < ApplicationController
  
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
    @article = Article.find(params[:id])
    
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
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was succesfully updated!"
      redirect_to article_path(@article)
    else
      render 'edit'
      
    end
  end
  
  #this method show articles from params by id
  def show
    @article = Article.find(params[:id])
  end
  
  private
  #this method grabs article params
    def article_params
      params.require(:article).permit(:title, :description)
    end
end