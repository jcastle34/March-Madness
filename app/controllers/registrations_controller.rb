class RegistrationsController < Devise::RegistrationsController
  layout "login"
  
  	def new
      	super  	
  	end

		def edit
      	super	
  	end
end