class Draft < ActiveRecord::Base
  has_many :draft_picks

  def self.is_completed?
    if(DraftPick.get_current_draft_pick.nil?)
      true
    else
      false
    end
  end

end
