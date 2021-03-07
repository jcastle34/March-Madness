class Region < ActiveRecord::Base
    has_one :bracket_entry

		EAST = 1
		SOUTHEAST = 2
		SOUTHWEST = 3
		WEST = 4

    def location_abbr
      region_id = self.id

      case region_id
        when 1 then return '2'
        when 2 then return '3'
        when 3 then return '1'
        when 4 then return '4'
      end

    end
end
