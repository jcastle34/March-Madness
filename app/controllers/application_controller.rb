class ApplicationController < ActionController::Base
    before_filter :authenticate_user!
    protect_from_forgery
    layout :layout_by_resource
    helper_method :get_team_for_current_user

    def layout_by_resource
        user_signed_in? ? 'application' : 'login'
    end

	def user_is_admin?
		unless current_user.is_admin?
            flash[:alert] = "Unauthorized Access"
            redirect_to root_path
            false
        end
    end

    def get_team_for_current_user
        MmTeam.find session['mm_team_id']
    end
  
end
