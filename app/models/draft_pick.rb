class DraftPick < ActiveRecord::Base
  belongs_to :draft
  belongs_to :mm_team
  belongs_to :ncaa_player

	# validates_uniqueness_of :ncaa_player_id
  
  def self.get_current_draft_pick
      draft_pick = DraftPick.find_by_sql("select * from draft_picks where ncaa_player_id is null order by overall_pick").first
  end
  
  def self.get_position_count
      DraftPick.find_by_sql("select np.position, count(np.position) as total from draft_picks dp join ncaa_players np on np.id = dp.ncaa_player_id group by np.position order by np.position desc")
  end

end
