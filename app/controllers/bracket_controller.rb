class BracketController < ApplicationController
  
  def index
    @east_region_bracket_entries = BracketEntry.where(:region_id => 1).order(:seed)
    @midwest_region_bracket_entries = BracketEntry.where(:region_id => 2).order(:seed)
    @south_region_bracket_entries = BracketEntry.where(:region_id => 3).order(:seed)
    @west_region_bracket_entries = BracketEntry.where(:region_id => 4).order(:seed)
  end

  def update_regions
    x = 0
    params.each do |key,value|
      if(key.include? "bracket_entry")
        key_values = key.split("_")
        bracket_entry = BracketEntry.find_by_seed_and_region_id(key_values[key_values.size - 1], key_values[key_values.size - 2])
        bracket_entry.update_attribute(:ncaa_team_id, value['ncaa_team_id'])
        flash[:notice] = t(:bracket_updated)
        #Rails.logger.warn "Seed: #{key_values[key_values.size - 1]} Region: #{key_values[key_values.size - 2]}"
        #Rails.logger.warn "#{value['ncaa_team_id']}"
      end
    end

    redirect_to bracket_index_url
  end

end
