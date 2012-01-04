class AddColumnToDraftPicks < ActiveRecord::Migration
  def self.up
      add_column :draft_picks, :draft_id, :integer
  end

  def self.down
  end
end
