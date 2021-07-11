class PostsController < ApplicationController
    before_action :authenticate_user!
    
    def show 
        @post = Post.find(params[:id])
        @user = @post.user
    end
    
    def new 
        @post = current_user.posts.new
    end
    
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = 'メッセージを投稿しました。'
            redirect_to root_url
        else
            @posts = current_user.posts.order(id: :desc)
            flash.now[:danger] = 'メッセージの投稿に失敗しました。'
            render 'home/index'
        end
    end
    
    private
    
    def post_params
        params.require(:post).permit(:image, :title, :content)
    end
end
