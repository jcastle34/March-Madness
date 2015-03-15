class BracketController < ApplicationController
  
  def index
    @east_region_bracket_entries = BracketEntry.where(:region_id => 1).order(:seed)
    @midwest_region_bracket_entries = BracketEntry.where(:region_id => 2).order(:seed)
    @south_region_bracket_entries = BracketEntry.where(:region_id => 3).order(:seed)
    @west_region_bracket_entries = BracketEntry.where(:region_id => 4).order(:seed)
  end

  def update_regions
    params.each do |key,value|
      if(key.include? "bracket_entry")
        key_values = key.split("_")
        bracket_entry = BracketEntry.find_by_seed_and_region_id_and_is_play_in(key_values[key_values.size - 2], key_values[key_values.size - 3], key_values[key_values.size - 1])
        bracket_entry.update_attribute(:ncaa_team_id, value['ncaa_team_id'])

        flash[:notice] = t(:bracket_updated)
      end
    end
    redirect_to admin_bracket_url
  end

end
