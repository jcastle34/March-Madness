class NcaaTeam < ActiveRecord::Base
  has_one :bracket_entry
  has_many :ncaa_players
end
