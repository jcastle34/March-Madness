class CreatePlayerScorings < ActiveRecord::Migration
  def self.up
    create_table :player_scorings do |t|
      t.integer :ncaa_player_id
      t.integer :round
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :player_scorings
  end
end
