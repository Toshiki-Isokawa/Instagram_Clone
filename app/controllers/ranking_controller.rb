class RankingController < ApplicationController
  def index
    @ranking_favorites = Post.find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @ranking_comments = Post.find(Comment.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end
end
