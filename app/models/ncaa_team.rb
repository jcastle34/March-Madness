class NcaaTeam < ActiveRecord::Base
  has_one :bracket_entry
  has_many :ncaa_players

  attr_accessible :school, :nickname

  def self.get_rosters
    NcaaTeam.joins(:ncaa_players).group(:ncaa_team_id).order(:school, "ncaa_players.position desc")
  end
end
