class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar]) 
    end
    
    def after_sign_in_path_for(resource)
        user_path(resource.id)
    end
    
    def user_counts(user)
        @count_posts = user.posts.count
        @count_user_likes = user.likes.count
    end
    
    def post_counts(post)
        @count_comments = post.comments.count
        @count_likes = post.likes.count
    end
end