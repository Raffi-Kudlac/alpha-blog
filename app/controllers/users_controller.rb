class UsersController < ApplicationController

  before_action :set_user, {only: [:edit, :update, :destroy, :show]}

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if (@user.save)
      flash[:success] = "Welcome to the Alpha App"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 10)
  end

  def update
    if (@user.update(user_params))
      flash[:success] = "The User was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find_by_id(params[:id])
    if (!@user)
      flash[:danger] = "The requested User could not be found"
      redirect_to articles_path
    end
  end
end
