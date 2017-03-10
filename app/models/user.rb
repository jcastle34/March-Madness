class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  has_many :mm_teams
  
	def is_admin?
		if is_admin == 1
			return true
		else
			return false
		end
  end

  def full_name
    if self.first_name.nil? || self.last_name.nil?
      ""
    else
      self.first_name + " " + self.last_name
    end
  end
end
