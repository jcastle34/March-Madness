require 'test_helper'

class NcaaPlayersControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	
  setup do
    @ncaa_player = ncaa_players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ncaa_players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ncaa_player" do
    assert_difference('NcaaPlayer.count') do
      post :create, :ncaa_player => @ncaa_player.attributes
    end

    assert_redirected_to ncaa_player_path(assigns(:ncaa_player))
  end

  test "should show ncaa_player" do
    get :show, :id => @ncaa_player.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ncaa_player.to_param
    assert_response :success
  end

  test "should update ncaa_player" do
    put :update, :id => @ncaa_player.to_param, :ncaa_player => @ncaa_player.attributes
    assert_redirected_to ncaa_player_path(assigns(:ncaa_player))
  end

  test "should destroy ncaa_player" do
    assert_difference('NcaaPlayer.count', -1) do
      delete :destroy, :id => @ncaa_player.to_param
    end

    assert_redirected_to ncaa_players_path
  end
end
