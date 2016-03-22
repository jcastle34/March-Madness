class PlayerScoringController < ApplicationController

  # GET /ncaa_teams
  # GET /ncaa_teams.xml
  def index
    @scoring_for_seeds_1_thru_4 = PlayerScoring.point_and_game_total_for_players_by_seed_range(1,4)
    @scoring_for_seeds_5_thru_8 = PlayerScoring.point_and_game_total_for_players_by_seed_range(5,8)
    @scoring_for_seeds_9_thru_12 = PlayerScoring.point_and_game_total_for_players_by_seed_range(9,12)
    @scoring_for_seeds_13_thru_16 = PlayerScoring.point_and_game_total_for_players_by_seed_range(13,16)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => [@scoring_for_seeds_1_thru_4, @scoring_for_seeds_5_thru_8, @scoring_for_seeds_9_thru_12, @scoring_for_seeds_13_thru_16] }
    end
  end

end
