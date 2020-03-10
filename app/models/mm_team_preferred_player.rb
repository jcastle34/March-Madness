class MmTeamPreferredPlayer < ActiveRecord::Base
	belongs_to :mm_team
	belongs_to :ncaa_player

  attr_accessible :mm_team_id, :ncaa_player_id

  	def add(mm_team_id, player_id_to_add)
		player_to_add = NcaaPlayer.find(player_id_to_add)
		seed = player_to_add.ncaa_team.bracket_entry.seed
		current_draft_pick = DraftPick.get_current_draft_pick

		if is_preferred_player_selection_valid?(mm_team_id, player_to_add)
			begin
				preferred_player = MmTeamPreferredPlayer.new(:mm_team_id => mm_team_id, :ncaa_player_id => player_id_to_add)
				preferred_player.save
			rescue ActiveRecord::RecordNotUnique
				errors[:base] << I18n.t(:preferred_player_already_added)
			end
		else
			errors[:base] << I18n.t(:invalid_roster)
		end
	end

	def is_preferred_player_selection_valid?(mm_team_id, player_to_draft)
		mm_team = MmTeam.find(mm_team_id)
		roster = mm_team.get_preferred_players
		total_guards = 0
		total_forwards = 0
		total_centers = 0
		player_seed_total = 0

		roster.each do |player|
			if player.position == NcaaPlayer::GUARD
				total_guards += 1
			elsif player.position == NcaaPlayer::FORWARD
				total_forwards += 1
			elsif player.position == NcaaPlayer::CENTER
				total_centers += 1
			end
		end

		total_players = total_guards + total_forwards + total_centers

		roster.each do |player|
			player_seed_total += player.ncaa_team.bracket_entry.seed 
		end

		if total_players >= 20
			return false
		elsif total_players == 19 && player_seed_total + player_to_draft.ncaa_team.bracket_entry.seed < 120
			return false
		end
		
	  	if total_forwards == 8 && player_to_draft.position == NcaaPlayer::FORWARD
			return false
	  	end
	  	if total_guards == 8 && player_to_draft.position == NcaaPlayer::GUARD
			return false
		end
		if total_centers == 4 && player_to_draft.position == NcaaPlayer::CENTER
			return false
		end

		true
	end

end
