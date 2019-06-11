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
      redirect_to articles_show(@article)
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
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
