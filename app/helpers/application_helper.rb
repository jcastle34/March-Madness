module ApplicationHelper
  def get_region_css_class region_id
		if region_id == Region::SOUTHEAST
			'southeast_region'
		elsif region_id == Region::SOUTHWEST
			'southwest_region'
		elsif region_id == Region::WEST 
			'west_region'
		elsif region_id == Region::EAST 
			'east_region'
		end
	end
	
end
