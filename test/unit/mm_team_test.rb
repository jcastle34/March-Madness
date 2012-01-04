require 'test_helper'

class MmTeamTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "get_players" do
		mm_team = MmTeam.find 1
		roster = mm_team.get_players
    assert_equal([], roster.inspect)
  end
end
