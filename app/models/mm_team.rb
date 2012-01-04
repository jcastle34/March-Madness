class MmTeam < ActiveRecord::Base
  belongs_to :user
  has_many :draft_picks
  has_many :ncaa_players
  
  def get_players
      # @ncaa_players = NcaaPlayer.joins('left outer join draft_picks dp on dp.ncaa_player_id = ncaa_players.id').where('dp.ncaa_player_id is NULL')
      @ncaa_players = NcaaPlayer.joins('left outer join draft_picks dp on dp.ncaa_player_id = ncaa_players.id
left outer join player_scorings ps on ps.ncaa_player_id = ncaa_players.id').where('dp.mm_team_id = ?', self.id).group('ncaa_players.id')
  end

end
