class NcaaPlayer < ActiveRecord::Base
  belongs_to :mm_team
  belongs_to :ncaa_team
  has_one :draft_pick
  has_many :mm_team_preferred_players
	has_many :player_scorings

  attr_accessible :first_name, :last_name, :ncaa_team_id, :ppg_avg, :position, :jersey_number

	GUARD = 'G'
	FORWARD = 'F'
	CENTER = 'C'
	GUARD_FORWARD = 'G-F'
	FORWARD_CENTER = 'F-C'
  POSITIONS = [GUARD, FORWARD, CENTER, GUARD_FORWARD, FORWARD_CENTER] 
  
  def full_name
      first_name + " " + last_name
  end
  
  def self.get_players_by_seed_range(start_value, end_value)
      if start_value < end_value
					NcaaPlayer.joins('join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id join bracket_entries be on be.ncaa_team_id = nt.id')
          .where('be.seed between ? and ? and ncaa_players.id not in (select ncaa_player_id from draft_picks where ncaa_player_id > 0)',
          start_value, end_value).order('be.seed asc, region_id, ncaa_players.ncaa_team_id asc, ncaa_players.position desc, ncaa_players.ppg_avg desc')
			else
          []
      end
  end

  def self.get_preferred_players_by_seed_range_for_mm_team(mm_team_id, start_value=1, end_value=16)
    if start_value < end_value
					NcaaPlayer.joins('join mm_team_preferred_players mtp on mtp.ncaa_player_id = ncaa_players.id join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id join bracket_entries be on be.ncaa_team_id = nt.id')
          .where('be.seed between ? and ? and mtp.mm_team_id = ? and ncaa_players.id not in (select ncaa_player_id from draft_picks where ncaa_player_id > 0)',
          start_value, end_value, mm_team_id).order('be.seed asc, ncaa_players.ppg_avg desc')
			else
          []
      end
  end

  def self.get_preferred_players_for_mm_team(mm_team_id)
          NcaaPlayer.joins('join mm_team_preferred_players mtp on mtp.ncaa_player_id = ncaa_players.id join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id join bracket_entries be on be.ncaa_team_id = nt.id')
          .where('mtp.mm_team_id = ?', mm_team_id).order('ncaa_players.position desc, ncaa_players.ppg_avg desc')
  end

  def self.get_players_by_position(position)
      if !position.empty?
          NcaaPlayer.joins('join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id join bracket_entries be on be.ncaa_team_id = nt.id')
          .where('ncaa_players.position = ?', position)
          .order('be.seed asc, region_id, ncaa_players.ncaa_team_id asc, ncaa_players.ppg_avg desc')
      else
          []
      end
  end

  def self.get_player_scoring_for_mm_team(mm_team)

  end
  
end
