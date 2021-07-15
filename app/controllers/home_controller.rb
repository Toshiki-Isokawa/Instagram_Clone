class HomeController < ApplicationController
  def index
    if user_signed_in?
      @posts = current_user.posts.order(id: :desc)
      @posts = @posts.page(params[:page]) 
    else
      @posts = Post.order(id: :desc)
      @posts = @posts.page(params[:page]) 
    end
  end
end
