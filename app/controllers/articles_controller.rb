class ArticlesController < ApplicationController
  
  #this method creates new article array
  def new
    @article = Article.new
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