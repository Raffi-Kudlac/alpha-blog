class ArticlesController < ApplicationController

  before_action :set_article, {only: [:edit, :update, :destroy, :show]}

  def index
    @articles = Article.paginate(page: params[:page], per_page: 1)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if (@article.save)
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render  'new'
    end
  end

  def update
    if (@article.update(article_params))
      flash[:success] = "The article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @article.destroy
  end

  def show
  end

  private
    def set_article
      @article = Article.find_by_id(params[:id])
      if (!@article)
        flash[:danger] = "The requested article could not be found"
        redirect_to articles_path
      end
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
