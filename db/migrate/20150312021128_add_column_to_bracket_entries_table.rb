class AddColumnToBracketEntriesTable < ActiveRecord::Migration
  def change
    add_column :bracket_entries, :is_play_in, :boolean, :default => 0
  end
end
