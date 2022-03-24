class Draft < ActiveRecord::Base
  has_many :draft_picks

  def get_current
			@current_draft_pick = DraftPick.get_current_draft_pick
      # Need to set the draft status to complete


      @position_counts = DraftPick.get_position_count
      @current_round_draft_picks = DraftPick.where(:round => @current_draft_pick.round)
      @last_player_drafted = DraftPick.where("ncaa_player_id > 0").last
  end

  def self.is_completed?
    if(DraftPick.get_current_draft_pick.nil?)
      true
    else
      false
    end
  end

end
