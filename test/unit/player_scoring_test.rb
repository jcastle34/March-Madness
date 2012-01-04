require 'test_helper'

class PlayerScoringTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "point_and_game_total_for_all_teams" do
      result = PlayerScoring.point_and_game_total_for_all_teams
      assert_equal(true, result.inspect)
  end
end
