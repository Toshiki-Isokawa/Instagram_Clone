class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    current_user.favorite(post)
    flash[:success] = 'この投稿をいいねしました。'
    redirect_to post
  end

  def destroy
    @post = Post.find(params[:post_id])
    user = @post.user
    current_user.unfavorite(user)
    flash[:success] = 'この投稿のいいねをやめました。'
    redirect_to @post
  end
end
