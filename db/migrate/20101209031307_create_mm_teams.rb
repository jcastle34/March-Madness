class CreateMmTeams < ActiveRecord::Migration
  def self.up
    create_table :mm_teams do |t|
      t.string :name
      t.integer :user_id
      t.integer :year
      t.timestamps
    end
  end

  def self.down
    drop_table :mm_teams
  end
end
