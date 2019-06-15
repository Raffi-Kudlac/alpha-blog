class CategoriesController < ApplicationController

  before_action :require_admin, except: [:show, :index]
  before_action:set_category, {only: [:edit, :update, :show, :destroy]}

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
    if (@category.update(category_params))
      flash[:success] = "Category name was successfully updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def create
    @category = Category.new(category_params)
    if (@category.save)
      flash[:success] = "Category created"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    if @category
      @category_articles = @category.articles.paginate(page: params[:page],
          per_page: 10)
      render 'show'
    else
      flash[:danger] = "The category could not be found"
      redirect_to categories_path
    end
  end

  private

  def set_category
    @category = Category.find_by(params[:id])
    if (!@category)
      flash[:danger] = "The category could not be found"
      redirect_to categories_path
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
