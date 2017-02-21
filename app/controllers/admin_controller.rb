class AdminController < ApplicationController
  before_filter :user_is_admin?

  def index    
      @ncaa_teams = NcaaTeam.all.order(:school)  
			@ncaa_players = NcaaPlayer.joins('join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id').order('nt.school asc, ncaa_players.position desc')      
  end

	def generate_draft_picks
      mm_teams = MmTeam.all
			pick_total = Draft.generate_draft_picks mm_teams
			flash[:notice] = "Total draft picks generated: " + pick_total.to_s
			redirect_to admin_index_url
	end

  def bracket
    @east_region_bracket_entries = BracketEntry.where(:region_id => 1).order(:seed)
    @midwest_region_bracket_entries = BracketEntry.where(:region_id => 2).order(:seed)
    @south_region_bracket_entries = BracketEntry.where(:region_id => 3).order(:seed)
    @west_region_bracket_entries = BracketEntry.where(:region_id => 4).order(:seed)
  end

end
