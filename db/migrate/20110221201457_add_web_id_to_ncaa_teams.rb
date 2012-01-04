class AddWebIdToNcaaTeams < ActiveRecord::Migration
  def self.up
    add_column :ncaa_teams, :web_id, :string
  end

  def self.down
    drop_table :ncaa_teams
  end

end
