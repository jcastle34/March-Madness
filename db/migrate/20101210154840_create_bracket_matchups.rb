class CreateBracketMatchups < ActiveRecord::Migration
  def self.up
    create_table :bracket_entries do |t|
      t.integer :ncaa_team_id
      t.integer :seed
      t.integer :region_id
      t.integer :year
      t.integer :round
      t.timestamps
    end
  end

  def self.down
    drop_table :bracket_entries
  end
end
