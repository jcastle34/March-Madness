class AdminController < ApplicationController
  before_filter :user_is_admin?

  def index    
      @draft_picks = DraftPick.where(:round => 1).order(:overall_pick)     
  end

  def lock_rosters
      draft_pick = DraftPick.find_by(overall_pick: 1)
      draft_pick.ncaa_player_id = 1
      draft_pick.save

      if draft_pick.errors.empty?
        flash[:notice] = t(:rosters_locked)
      else
        flash[:alert] = draft_pick.errors.full_messages.to_sentence
      end

      redirect_to admin_index_url
  end

  def unlock_rosters
      draft_pick = DraftPick.find_by(overall_pick: 1)
      draft_pick.ncaa_player_id = nil
      draft_pick.save

      if draft_pick.errors.empty?
        flash[:notice] = t(:rosters_unlocked)
      else
        flash[:alert] = draft_pick.errors.full_messages.to_sentence
      end

      redirect_to admin_index_url
  end

  def bracket
    @east_region_bracket_entries = BracketEntry.where(:region_id => 1).order(:seed)
    @midwest_region_bracket_entries = BracketEntry.where(:region_id => 2).order(:seed)
    @south_region_bracket_entries = BracketEntry.where(:region_id => 3).order(:seed)
    @west_region_bracket_entries = BracketEntry.where(:region_id => 4).order(:seed)
    @play_in_matchups = BracketEntry.where(:is_play_in => 1).order(:seed, :region_id)
  end

end
