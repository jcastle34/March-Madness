require 'test_helper'

class NcaaPlayerTest < ActiveSupport::TestCase
  
  test "get_players_by_seed_range 1 thru 4" do
      result = NcaaPlayer.get_players_by_seed_range(1, 4)
      assert_equal(2, result.size)
  end
end
