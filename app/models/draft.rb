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

	def draft_player player_id
			player = NcaaPlayer.find(player_id)
			seed = player.ncaa_team.bracket_entry.seed
			current_draft_pick = DraftPick.get_current_draft_pick
			
			if draft_pick_seed_valid? seed, current_draft_pick
				if roster_valid? current_draft_pick.mm_team_id, player.position
					begin
						pick = DraftPick.find_by_overall_pick(current_draft_pick.overall_pick)
						pick.ncaa_player_id = player_id
						pick.save
					rescue ActiveRecord::RecordNotUnique
						errors[:base] << I18n.t(:player_already_drafted)
					end
				else
					errors[:base] << I18n.t(:invalid_roster)
					false
				end
			else
				errors[:base] << I18n.t(:ineligible_player_draftpick)
				false
			end
	end
	
	def self.generate_draft_picks mm_teams
		draft = Draft.find(1)
		total_teams = draft.total_teams
		total_rounds = draft.total_rounds
		overall_pick = 0
		round = 1
		
		@picks = DraftPick.all
		@picks.each { |pick| pick.destroy }

    mm_teams = mm_teams.shuffle

		while round <= total_rounds
			DraftPick.transaction do
				mm_teams.each do |team|
						overall_pick =+ overall_pick + 1
						draft_pick = DraftPick.new
						draft_pick.id = overall_pick
						draft_pick.overall_pick = overall_pick
						draft_pick.round = round
						draft_pick.mm_team_id = team.id
						draft_pick.ncaa_player_id = nil
						draft_pick.save!			
				end
			end
			
			round =+ round + 1
			
			if round != 3
				mm_teams = mm_teams.reverse
			end
		end
		
		return overall_pick
  end

  def self.is_configured?
    Draft.exists?(1) && DraftPick.find(:all).count > 0
  end

  def self.is_completed?
    if(DraftPick.get_current_draft_pick.nil?)
      true
    else
      false
    end
  end
	
	private
	
	def draft_pick_seed_valid? seed, current_draft_pick
		valid_draft_pick_seed = false
		
		if current_draft_pick.round == 1 || current_draft_pick.round == 2
			if seed < 5
				valid_draft_pick_seed = true
			end
		elsif current_draft_pick.round == 3
			if @@round_3_seed_range === seed
				valid_draft_pick_seed = true
			end
		elsif current_draft_pick.round == 4
			if @@round_4_seed_range === seed
				valid_draft_pick_seed = true
			end		
		elsif current_draft_pick.round == 5
			if @@round_5_seed_range === seed
				valid_draft_pick_seed = true
			end
		else current_draft_pick.round == 6
			valid_draft_pick_seed = true
		end
		
		return valid_draft_pick_seed
	end
	
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
