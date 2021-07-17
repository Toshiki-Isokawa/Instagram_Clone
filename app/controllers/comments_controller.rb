class CommentsController < ApplicationController
    
    def create
        @comment = current_user.comments.new(comment_params)
        @post = Post.find(params[:post_id])
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        
        if @comment.save
          redirect_back(fallback_location: root_path)  
        else
          redirect_back(fallback_location: root_path) 
        end
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.find_by(id: params[:id])
        if @comment.user = current_user
            @comment.destroy
            redirect_to post_path(@post)
        else
            redirect_to post_path(@post)
        end
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:comment_content, :post_id)
    end
    
end
