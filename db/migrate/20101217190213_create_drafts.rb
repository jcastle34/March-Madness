class CreateDrafts < ActiveRecord::Migration
  def self.up
    create_table :drafts do |t|
      t.integer :total_rounds
      t.integer :total_teams

      t.timestamps
    end
  end

  def self.down
    drop_table :drafts
  end
end
