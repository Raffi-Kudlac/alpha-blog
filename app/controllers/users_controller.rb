class UsersController < ApplicationController

  before_action :require_user, {except: [:index, :show]}
  before_action :set_user, {only: [:edit, :update, :destroy, :show]}
  before_action :require_same_user, {only: [:edit, :update, :destroy]}
  before_action :require_admin, {only: [:destroy]}

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if (@user.save)
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha App"
      redirect_to user_path(@user)
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

  def destroy
    if !@user.admin?
      @user.destroy
      flash[:danger] = "All articles by this user have been deleted"
      redirect_to users_path
    else
      flash[:danger] = "The Admin can not be deleted"
      redirect_to users+path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if (current_user() != @user && !current_user().admin?)
      flash[:danger] = "You can only alter your own user"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find_by_id(params[:id])
    if (!@user)
      flash[:danger] = "The requested User could not be found"
      redirect_to articles_path
    end
  end  
end
