class HomeController < ApplicationController

  def index
    @standings = PlayerScoring.point_and_game_total_for_all_teams
		@top_scorers = PlayerScoring.point_and_game_total_for_players
  end

	def player_scoring_details
		player_id = params[:player_id]
		@scoring_details = PlayerScoring.details_for_player(player_id)
	end

end
