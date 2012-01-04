class CreateNcaaTeams < ActiveRecord::Migration
  def self.up
    create_table :ncaa_teams do |t|
      t.string :school
      t.string :nickname
      t.integer :is_active
      t.timestamps
    end
  end

  def self.down
    drop_table :ncaa_teams
  end
end
