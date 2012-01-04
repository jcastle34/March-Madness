require 'test_helper'

class NcaaTeamsControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	
  setup do
    @ncaa_team = ncaa_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ncaa_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ncaa_team" do
    assert_difference('NcaaTeam.count') do
      post :create, :ncaa_team => @ncaa_team.attributes
    end

    assert_redirected_to ncaa_team_path(assigns(:ncaa_team))
  end

  test "should show ncaa_team" do
    get :show, :id => @ncaa_team.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ncaa_team.to_param
    assert_response :success
  end

  test "should update ncaa_team" do
    put :update, :id => @ncaa_team.to_param, :ncaa_team => @ncaa_team.attributes
    assert_redirected_to ncaa_team_path(assigns(:ncaa_team))
  end

  test "should destroy ncaa_team" do
    assert_difference('NcaaTeam.count', -1) do
      delete :destroy, :id => @ncaa_team.to_param
    end

    assert_redirected_to ncaa_teams_path
  end
end
