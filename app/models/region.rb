class Region < ActiveRecord::Base
    has_one :bracket_entry

		EAST = 1
		MIDWEST = 2
		SOUTH = 4
		WEST = 3

    def location_abbr
      region_id = self.id

      case region_id
        when 1 then return 'E'
        when 2 then return 'M'
        when 3 then return 'W'
        when 4 then return 'S'
      end

    end
end
