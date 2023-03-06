class AddRosterLockToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :roster_lock, :datetime 
  end
end
