require 'draft_pick'

class DraftController < ApplicationController
	include DraftHelper
  include DraftExtension

	def index
    # load initial draft page
    if (Draft.is_configured?)
      if(Draft.is_completed?)
        redirect_to :action => 'results'
      else
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
          flash[:alert] = t(:no_team_for_user)
          redirect_to root_path
        end
      end
    else
      flash[:alert] = t(:draft_not_setup)
      redirect_to root_path
    end
	end

	def get_current_draft_status
    if(!Draft.is_completed?)
			@draft = Draft.find(1)
			@draft.get_current
			previous_pick = params[:previous_pick].to_i

			if previous_pick != @draft.current_draft_pick.overall_pick
				@selected_round = @draft.current_draft_pick.round
			else
				render :nothing => true
      end
    else
      if request.xhr?
        flash[:notice] = t(:draft_completed)
        flash.keep(:notice) # Keep flash notice around for the redirect.
        render :js => "window.location = #{draft_results_path.to_json}"
      end
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
						flash[:notice] = t(:player_drafted)
					else
						flash[:alert] = draft.errors.full_messages.to_sentence
					end
			else
					flash[:alert] = t(:out_of_turn_draft_pick)
			end

			redirect_to draft_index_path
	end

	def undraft_player
	end

	def start

	end

	def stop
  end

  def results
    @draft_picks = DraftPick.get_all
  end

  def get_eligible_players_by_round
    @mm_team = MmTeam.find(get_team_for_current_user)
    @selected_round = params[:selected_round]
    seed_range = get_seed_ranges_by_round @selected_round.to_i
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
    render "shared/get_eligible_players_by_round"
  end

  def get_preferred_players_by_round
    @mm_team = MmTeam.find(get_team_for_current_user)
    @selected_round = params[:selected_round]
    seed_range = get_seed_ranges_by_round @selected_round.to_i
    @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(get_team_for_current_user, seed_range[0], seed_range[1])
    render "shared/get_preferred_players_by_round"
  end

	private

    def get_roster_for_current_user
      if !get_team_for_current_user.nil?
        mm_team = get_team_for_current_user
        @my_roster = mm_team.get_players
      end
    end
end
