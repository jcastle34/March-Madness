class AddUniqueConstraintToPlayerScoring < ActiveRecord::Migration
  def change
    add_index :player_scorings, [:ncaa_player_id, :round], :unique => true
  end
end
