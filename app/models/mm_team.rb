class MmTeam < ActiveRecord::Base
  belongs_to :user
  has_many :draft_picks
  has_many :ncaa_players

  attr_accessible :name

  def get_players
      @ncaa_players = NcaaPlayer.joins('left outer join draft_picks dp on dp.ncaa_player_id = ncaa_players.id
left outer join player_scorings ps on ps.ncaa_player_id = ncaa_players.id').where('dp.mm_team_id = ?', self.id).group('ncaa_players.id')
  end

  def self.get_rosters
    @ncaa_players = NcaaPlayer.joins('inner join draft_picks dp on dp.ncaa_player_id = ncaa_players.id
inner join mm_teams mt on mt.id = dp.mm_team_id').order('mt.name')
  end

  def self.active_players_count_for_team(mm_team_id)
    NcaaPlayer.joins('left outer join draft_picks dp on dp.ncaa_player_id = ncaa_players.id
left outer join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id').where('dp.mm_team_id = ? and nt.is_active = ?', mm_team_id, 1).count()
  end

end
