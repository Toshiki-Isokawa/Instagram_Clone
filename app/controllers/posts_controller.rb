class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:destroy]
    
    def show 
        @post = Post.find(params[:id])
        @comment = current_user.comments.new
        @comments = @post.comments
    
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
            render 'new'
        end
    end
    
    def destroy
        @post = current_user.posts.find_by(id: params[:id])
        @post.destroy
        flash[:success] = '削除しました。'
        redirect_to root_url
    end
    
    private
    
    def post_params
        params.require(:post).permit(:image, :title, :content)
    end
    
    def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        unless @post
            redirect_to root_url
        end
    end
end
