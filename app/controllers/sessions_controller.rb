class SessionsController < Devise::SessionsController
  layout "login"
  
  def new
    super
  end

  def create
    super
#      reset_session
    mm_team = MmTeam.find_by_user_id(current_user.id)
    if !mm_team.nil?
      session['mm_team_id'] = mm_team.id
    else
      flash[:alert] = "No Team is associated with the current user."
    end
  end

  def destroy
    super
    reset_session
  end

end
