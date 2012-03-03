class CreateMmTeamPreferredPlayers < ActiveRecord::Migration
  def change
    create_table :mm_team_preferred_players do |t|
      t.integer :mm_team_id
      t.integer :ncaa_player_id

      t.timestamps
    end

    add_index "mm_team_preferred_players", ["ncaa_player_id", "mm_team_id"], :unique => true
  end
end
