class AddWebIdToNcaaPlayer < ActiveRecord::Migration
  def change
    add_column :ncaa_players, :web_id, :string
  end
end
