require 'draft_pick'

class DraftController < ApplicationController
	include DraftHelper
	
	def index
		# load initial draft page
			@draft = Draft.find(1)
			@draft.get_current
			@selected_round = @draft.current_draft_pick.round
			seed_range = get_seed_ranges_by_round @selected_round
			@ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
			get_roster_for_current_user
	end
	
	def get_current_draft_status 
			@draft = Draft.find(1)
			@draft.get_current
			previous_pick = params[:previous_pick].to_i
		
			if previous_pick != @draft.current_draft_pick.overall_pick
				@selected_round = @draft.current_draft_pick.round
			else
				render :nothing => true
			end
	end
	
	def get_eligible_players_by_round
			@selected_round = params[:selected_round]
			seed_range = get_seed_ranges_by_round @selected_round.to_i
			@ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
	end
	
	def get_by_ncaa_team
			@ncaa_players = NcaaPlayer.where(:ncaa_team_id => params[:ncaa_team_id])
	end

	def draft_player
			current_draft_pick = DraftPick.get_current_draft_pick
			
			# Check to see if it is the users turn to draft
			if session[:mm_team_id] == current_draft_pick.mm_team_id || current_user.is_admin?
					# Draft Player
					draft = Draft.find(1)
					result = draft.draft_player params[:id]
					if draft.errors.empty?
						flash[:notice] = "Player was successfully drafted"
					else
						flash[:alert] = draft.errors.full_messages.to_sentence
					end
			else	
					# Return Message stating that it is not your pick
					flash[:alert] = "It is not your turn to draft a player."
			end
			
			redirect_to draft_index_path
	end

	def undraft_player
	end

	def start
			
	end

	def stop
	end
	
	private
	
    def get_roster_for_current_user
      if !session['mm_team_id'].nil?
        mm_team = MmTeam.find session['mm_team_id']
        @my_roster = mm_team.get_players
      end
    end
end
