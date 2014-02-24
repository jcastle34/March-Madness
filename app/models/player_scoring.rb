class PlayerScoring < ActiveRecord::Base
	belongs_to :ncaa_player
  
  def self.point_and_game_total_for_all_teams
      self.find_by_sql("select mt.id, mt.name, sum(ps.points) as total_points, count(ps.round) as total_games from player_scorings ps
            join ncaa_players np on np.id = ps.ncaa_player_id 
            join draft_picks dp on dp.ncaa_player_id = np.id 
            join ncaa_teams nt on nt.id = np.ncaa_team_id
            right outer join mm_teams mt on mt.id = dp.mm_team_id 
            group by mt.id order by total_points desc")
  end

	def self.point_and_game_total_for_players
      self.find_by_sql("select np.id, np.first_name, np.last_name, mt.name as team_name, sum(ps.points) as total_points, count(ps.round) as total_games from player_scorings ps 
			            join ncaa_players np on np.id = ps.ncaa_player_id 
			            join draft_picks dp on dp.ncaa_player_id = np.id 
			            join ncaa_teams nt on nt.id = np.ncaa_team_id
			            join mm_teams mt on mt.id = dp.mm_team_id 
			            group by np.id order by total_points desc limit 50")
  end

	def self.details_for_player(player_id)
			PlayerScoring.joins('join ncaa_players np on np.id = player_scorings.ncaa_player_id').where("player_scorings.ncaa_player_id = ?", player_id)
  end
  
end
