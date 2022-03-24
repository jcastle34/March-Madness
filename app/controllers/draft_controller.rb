require 'draft_pick'

class DraftController < ApplicationController
	include DraftHelper
  include DraftExtension

	def index

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

  def results
    @draft_picks = DraftPick.get_all
  end

	private

    def get_roster_for_current_user
      if !get_team_for_current_user.nil?
        mm_team = get_team_for_current_user
        @my_roster = mm_team.get_players
      end
    end
end
