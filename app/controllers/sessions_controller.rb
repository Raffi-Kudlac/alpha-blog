class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if (user && user.authenticate(params[:session][:password]))
      flash[:success] = "You have successfuly loged in"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:danger] = "The login was not successful"
      render 'new'
    end
  end

  def destroy
    if (session[:user_id])
      session[:user_id] = nil
      flash[:success] = "You have successfuly loged out"
      redirect_to root_path
    else
      flash.now[:warning] = "You need to be loggedin to log out"
      redirect_back(fallback_location: root_path)
    end
  end
end
