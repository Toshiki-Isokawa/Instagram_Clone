class HomeController < ApplicationController
  def index
    if user_signed_in?
      @posts = current_user.posts.order(id: :desc)
    end
  end
end
