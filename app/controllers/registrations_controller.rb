class RegistrationsController < Devise::RegistrationsController
  
  def new
    if(Draft.is_completed?)
      flash[:alert] = t(:no_new_registrations)
      redirect_to(new_user_session_path)
    else
      super
    end
  end

  def edit
    super
  end
end