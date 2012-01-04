class CreateDraftPicks < ActiveRecord::Migration
  def self.up
    create_table :draft_picks do |t|
      t.integer :overall_pick
      t.integer :round
      t.integer :ncaa_player_id
      t.integer :mm_team_id

      t.timestamps
    end

  end

  def self.down
    drop_table :draft_picks
  end
end
