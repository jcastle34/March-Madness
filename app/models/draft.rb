class Draft < ActiveRecord::Base
  has_many :draft_picks

	attr_accessor :current_draft_pick
	attr_accessor :position_counts
	attr_accessor :current_round_draft_picks
	attr_accessor :last_player_drafted

	@@round_3_seed_range = (5..8)
	@@round_4_seed_range = (9..12)
	@@round_5_seed_range = (13..16)

  def get_current
			@current_draft_pick = DraftPick.get_current_draft_pick
      # Need to set the draft status to complete


      @position_counts = DraftPick.get_position_count
      @current_round_draft_picks = DraftPick.where(:round => @current_draft_pick.round)
      @last_player_drafted = DraftPick.where("ncaa_player_id > 0").last
  end

  def self.is_configured?
    Draft.exists?(1) && DraftPick.all.count > 0
  end

  def self.is_completed?
    if(DraftPick.get_current_draft_pick.nil?)
      true
    else
      false
    end
  end

	private


	def roster_valid? mm_team_id, position_to_draft
		mm_team = MmTeam.find(mm_team_id)
		roster = mm_team.get_players
		total_guards = 0
		total_forwards = 0
		total_centers = 0

		roster.each do |player|
			if player.position == NcaaPlayer::GUARD
				total_guards += 1
			elsif player.position == NcaaPlayer::FORWARD
				total_forwards += 1
			elsif player.position == NcaaPlayer::CENTER
				total_centers += 1
			end
		end

		if total_guards + total_forwards + total_centers == 5
			if total_centers == 0 && position_to_draft != NcaaPlayer::CENTER
				return false
      end
      if total_forwards == 1 && position_to_draft != NcaaPlayer::FORWARD
				return false
      end
      if total_guards == 1 && position_to_draft != NcaaPlayer::GUARD
				return false
			end
    end

		if position_to_draft == NcaaPlayer::GUARD && total_guards > 2
			return false
		elsif position_to_draft == NcaaPlayer::FORWARD && total_forwards > 2
			return false
		elsif position_to_draft == NcaaPlayer::CENTER && total_centers > 1
			return false
		else
			return true
    end

	end

end
