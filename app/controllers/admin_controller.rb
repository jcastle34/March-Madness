class AdminController < ApplicationController
  before_filter :user_is_admin?

  def index    
      @ncaa_teams = NcaaTeam.find(:all, :order => "school")  
			@ncaa_players = NcaaPlayer.joins('join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id').order('nt.school asc, ncaa_players.position desc')      
  end

	def generate_draft_picks
			pick_total = Draft.generate_draft_picks [16, 20, 19, 2, 5, 11, 3, 7, 13, 15, 4, 10, 18, 12, 1, 9, 8, 17, 14, 6]
			flash[:notice] = "Total draft picks generated: " + pick_total.to_s
			redirect_to admin_index_url
	end

end
