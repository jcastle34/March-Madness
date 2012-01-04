class ApplicationController < ActionController::Base
    before_filter :authenticate_user!
    protect_from_forgery
    layout :layout_by_resource

    def layout_by_resource
      is_a?(Devise::SessionsController) || is_a?(Devise::PasswordsController) ? "login" : "application"
    end


		def user_is_admin?
			unless current_user.is_admin?
			    flash[:alert] = "Unauthorized Access"
			    redirect_to home_index_path
			    false
			  end
		end
  
end
