require 'test_helper'

class BracketControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	
  setup do
    @bracket_entry = bracket_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bracket_entries)
  end

end
