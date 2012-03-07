module DraftHelper
	def get_seed_ranges_by_round round
		case round
		when 1, 2 
				start_value = 1
				end_value = 4
		when 3
				start_value = 5
				end_value = 8
		when 4
				start_value = 9
				end_value = 12
		when 5
				start_value = 13
				end_value = 16
		when 6
				start_value = 1
				end_value = 16
		end

		return [start_value, end_value]
	end
end
