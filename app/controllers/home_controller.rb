class HomeController < ApplicationController
  def index
    @posts = Post.order(id: :desc)
    @posts = @posts.page(params[:page]) 
  end
end
