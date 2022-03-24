require 'draft_pick'

class DraftController < ApplicationController
	include DraftHelper
  include DraftExtension

	def index

	end

	def get_by_ncaa_team
			@ncaa_players = NcaaPlayer.where(:ncaa_team_id => params[:ncaa_team_id])
	end

	private

    def get_roster_for_current_user
      if !get_team_for_current_user.nil?
        mm_team = get_team_for_current_user
        @my_roster = mm_team.get_players
      end
    end
end
