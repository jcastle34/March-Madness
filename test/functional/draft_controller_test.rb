require 'test_helper'

class DraftControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get draft_player" do
    get :draft_player
    assert_response :success
  end

  test "should get undraft_player" do
    get :undraft_player
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get stop" do
    get :stop
    assert_response :success
  end

end
