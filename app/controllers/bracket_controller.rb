class BracketController < ApplicationController

  def index
    if(BracketEntry.is_configured?)
        @east_region_bracket_entries = matchup_seeds(BracketEntry.where(:region_id => 1).order(:seed))
        @midwest_region_bracket_entries = matchup_seeds(BracketEntry.where(:region_id => 2).order(:seed))
        @south_region_bracket_entries = matchup_seeds(BracketEntry.where(:region_id => 3).order(:seed))
        @west_region_bracket_entries = matchup_seeds(BracketEntry.where(:region_id => 4).order(:seed))
        @play_in_matchups = BracketEntry.where(:is_play_in => 1).order(:seed, :region_id)
    else
        redirect_to root_path
        flash[:error] = t(:bracket_not_setup)
    end
  end

  def update_regions
    params.each do |key,value|
      if(key.include? "bracket_entry_")
        # key_values = key.split("_")
        # bracket_entry = BracketEntry.find_by_seed_and_region_id_and_is_play_in(key_values[key_values.size - 2], key_values[key_values.size - 3], key_values[key_values.size - 1])
        actual_key = key.gsub("bracket_entry_", '')
        bracket_entry = BracketEntry.find(actual_key)
        bracket_entry.update_attribute(:ncaa_team_id, value['ncaa_team_id'])

        ncaa_team = NcaaTeam.find_by_id(value['ncaa_team_id'])
        ncaa_team.update_attribute(:is_active, 1)

        flash[:notice] = t(:bracket_updated)
      end
    end
    redirect_to admin_bracket_url
  end

private

  def matchup_seeds(bracket_entries)
    matchups = []
        matchups.push bracket_entries.find {|be| be.seed == 1}
        matchups.push bracket_entries.find {|be| be.seed == 16}
        matchups.push bracket_entries.find {|be| be.seed == 8}
        matchups.push bracket_entries.find {|be| be.seed == 9}
        matchups.push bracket_entries.find {|be| be.seed == 5}
        matchups.push bracket_entries.find {|be| be.seed == 12}
        matchups.push bracket_entries.find {|be| be.seed == 4}
        matchups.push bracket_entries.find {|be| be.seed == 13}
        matchups.push bracket_entries.find {|be| be.seed == 6}
        matchups.push bracket_entries.find {|be| be.seed == 11}
        matchups.push bracket_entries.find {|be| be.seed == 3}
        matchups.push bracket_entries.find {|be| be.seed == 14}
        matchups.push bracket_entries.find {|be| be.seed == 7}
        matchups.push bracket_entries.find {|be| be.seed == 10}
        matchups.push bracket_entries.find {|be| be.seed == 2}
        matchups.push bracket_entries.find {|be| be.seed == 15}
  end

end
