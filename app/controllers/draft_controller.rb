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
      @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(get_current_user)
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

  def get_preferred_players_by_round
			@selected_round = params[:selected_round]
			seed_range = get_seed_ranges_by_round @selected_round.to_i
      @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(get_current_user, seed_range[0], seed_range[1])
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

  def preferred_players
      @draft = Draft.find(1)
			@draft.get_current
      @selected_round = @draft.current_draft_pick.round
      seed_range = get_seed_ranges_by_round @selected_round
      @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
			@preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(get_current_user, seed_range[0], seed_range[1])
  end

  def add_preferred_player
    preferred_player = MmTeamPreferredPlayer.new(:mm_team_id => session['mm_team_id'], :ncaa_player_id => params[:id])
    preferred_player.save
    flash[:notice] = "Player was successfully added to your list of preferred players."
    redirect_to :action => :preferred_players
  rescue ActiveRecord::RecordNotUnique
    flash[:alert] = "This player has already been added to your preferred list."
    redirect_to :action => :preferred_players
  end

  def remove_preferred_player
    preferred_player = MmTeamPreferredPlayer.find_by_ncaa_player_id(params[:id])
    preferred_player.delete
    flash[:notice] = "Player was successfully removed from your list of preferred players."
    redirect_to :action => :preferred_players
  rescue Exception
    flash[:alert] = "There was a problem removing the player."
    redirect_to :action => :preferred_players
  end
	
	private
	
    def get_roster_for_current_user
      if !get_current_user.nil?
        mm_team = get_current_user
        @my_roster = mm_team.get_players
      end
    end
end
