class Region < ActiveRecord::Base
    has_one :bracket_entry

		EAST = 1
		SOUTHEAST = 2
		SOUTHWEST = 3
		WEST = 4

    def location_abbr
      region_id = self.id

      case region_id
        when 1 then return 'S'
        when 2 then return 'M'
        when 3 then return 'W'
        when 4 then return 'E'
      end

    end
end
