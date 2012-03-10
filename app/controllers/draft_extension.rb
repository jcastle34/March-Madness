module DraftExtension
  extend ActiveSupport::Concern

  module ClassMethods
    
  end

  module InstanceMethods
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
  end
end