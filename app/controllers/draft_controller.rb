require 'draft_pick'

class DraftController < ApplicationController
	include DraftHelper
  include DraftExtension
	
	def index
    # load initial draft page
    if (Draft.configured?)
      @draft = Draft.find(1)
      @draft.get_current
      @selected_round = @draft.current_draft_pick.round
      seed_range = get_seed_ranges_by_round @selected_round
      @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
      if(session['mm_team_id'])
        @mm_team = MmTeam.find(get_team_for_current_user)
        @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(@mm_team.id)
        get_roster_for_current_user
        @my_draft_picks = DraftPick.where("mm_team_id = ?", get_team_for_current_user)
      else
        flash[:alert] = "The current user is not associated with a March Madness Team."
        redirect_to root_path
      end
    else
      flash[:alert] = "The draft does not exist yet."
      redirect_to root_path
    end
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
      if !get_team_for_current_user.nil?
        mm_team = get_team_for_current_user
        @my_roster = mm_team.get_players
      end
    end
end
