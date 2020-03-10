class MmTeam < ActiveRecord::Base
  belongs_to :user
  has_many :draft_picks
  has_many :ncaa_players
  has_many :mm_team_preferred_players

  attr_accessible :name, :user_id

  def get_players
    @ncaa_players = NcaaPlayer.joins('left outer join draft_picks dp on dp.ncaa_player_id = ncaa_players.id
left outer join player_scorings ps on ps.ncaa_player_id = ncaa_players.id').where('dp.mm_team_id = ?', self.id).group('ncaa_players.id')
  end

  def self.get_rosters
    @ncaa_players = NcaaPlayer.joins('inner join draft_picks dp on dp.ncaa_player_id = ncaa_players.id
inner join mm_teams mt on mt.id = dp.mm_team_id').order('mt.name')
  end

  def self.get_all_rosters
    @ncaa_players = MmTeamPreferredPlayer.joins('inner join ncaa_players np on mm_team_preferred_players.ncaa_player_id = np.id
inner join mm_teams mt on mt.id = mm_team_preferred_players.mm_team_id').order('mt.name', 'np.position desc', 'np.ppg_avg desc')
  end

  def self.active_players_count_for_team(mm_team_id)
    NcaaPlayer.joins('left outer join mm_team_preferred_players pp on pp.ncaa_player_id = ncaa_players.id
left outer join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id').where('pp.mm_team_id = ? and nt.is_active = ?', mm_team_id, 1).count()
  end

  def get_preferred_players
      @ncaa_players = NcaaPlayer.joins('left outer join mm_team_preferred_players pp on pp.ncaa_player_id = ncaa_players.id').where('pp.mm_team_id = ?', self.id)
  end

  def get_players_seed_total(mm_team_id)
    mm_team = MmTeam.find(mm_team_id)
    roster = mm_team.get_preferred_players
    player_seed_total = 0

    roster.each { |player| player_seed_total = player_seed_total + player.ncaa_team.bracket_entry.seed}
    player_seed_total
  end

end
