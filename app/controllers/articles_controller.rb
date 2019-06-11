class ArticlesController < ApplicationController

  before_action :set_article, {only: [:update, :destroy, :show]}

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if (@article.save)
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render  'new'
    end
  end

  def update
  end

  def edit
  end

  def destroy
    if (@article)
      @article.destroy
    end
  end

  def show
    if (!@article)
      redirect_to 'index'
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
