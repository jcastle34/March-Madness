class CreateNcaaPlayers < ActiveRecord::Migration
  def self.up
    create_table :ncaa_players do |t|
      t.string :first_name
      t.string :last_name
      t.integer :ncaa_team_id
      t.decimal :ppg_avg
      t.string :position
      t.timestamps
    end
  end

  def self.down
    drop_table :ncaa_players
  end
end
