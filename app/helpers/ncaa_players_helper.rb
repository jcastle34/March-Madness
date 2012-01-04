module NcaaPlayersHelper
	
	def get_position_css_class position
		if position == 'G'
			'position_guard'
		elsif position == 'F'
			'position_forward'
		elsif position == 'C' 
			'position_center'
		end
	end
	
end
