class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    
    def twitter
        callback_for(:twitter)
    end
    
    def facebook
        callback_for(:facebook)  
    end
    
    def google_oauth2
        @user = User.find_for_google_oauth2(request.env["omniauth.auth"].except("extra"))
    
        if @user.persisted? 
          sign_in_and_redirect @user
        else                
          session["devise.user_attributes"] = @user.attributes                 
          redirect_to new_user_registration_url   
        end
    end
    
    def failure
        redirect_to root_path
    end
    
    private
    
    def callback_for(provider)
        @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))
    
        if @user.persisted? 
          sign_in_and_redirect @user
        else                
          session["devise.user_attributes"] = @user.attributes                 
          redirect_to new_user_registration_url   
        end
    end
end
