class HomeController < ApplicationController

	def index
		mm_team = MmTeam.find_by_user_id(current_user.id)
		if !mm_team.nil?
		  session['mm_team_id'] = mm_team.id
		else
		  flash[:alert] = t(:no_team_for_user)
		  redirect_to new_mm_team_path
		end

		@standings = PlayerScoring.point_and_game_total_for_all_teams
		@top_scorers = PlayerScoring.point_and_game_total_for_players
	end

	def player_scoring_details
		player_id = params[:player_id]
		@scoring_details = PlayerScoring.details_for_player(player_id)
	end

end
