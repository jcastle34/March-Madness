class AddConstraintToNcaaPlayer < ActiveRecord::Migration
  def change
    add_index :ncaa_players, [:first_name, :last_name, :ncaa_team_id], :unique => true
  end
end
