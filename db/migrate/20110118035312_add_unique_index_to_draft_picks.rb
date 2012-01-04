class AddUniqueIndexToDraftPicks < ActiveRecord::Migration
  def self.up
			add_index "draft_picks", ["ncaa_player_id"], :unique => true
  end

  def self.down
  end
end
