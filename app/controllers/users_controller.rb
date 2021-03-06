class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    user_counts(@user)
  end
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    user_counts(@user)
  end
end
