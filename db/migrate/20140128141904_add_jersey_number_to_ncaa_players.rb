class AddJerseyNumberToNcaaPlayers < ActiveRecord::Migration
  def change
    add_column :ncaa_players, :jersey_number, :integer

  end
end
