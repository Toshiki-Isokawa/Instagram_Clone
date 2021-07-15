class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar]) 
    end
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar]) 
    end
    
    def after_sign_in_path_for(resource)
        user_path(resource.id)
    end
    
    def counts(user)
        @count_posts = user.posts.count
    end
end