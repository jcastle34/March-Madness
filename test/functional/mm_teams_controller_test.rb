require 'test_helper'

class MmTeamsControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	
  setup do
    @mm_team = mm_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mm_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mm_team" do
    assert_difference('MmTeam.count') do
      post :create, :mm_team => @mm_team.attributes
    end

    assert_redirected_to mm_team_path(assigns(:mm_team))
  end

  test "should show mm_team" do
    get :show, :id => @mm_team.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mm_team.to_param
    assert_response :success
  end

  test "should update mm_team" do
    put :update, :id => @mm_team.to_param, :mm_team => @mm_team.attributes
    assert_redirected_to mm_team_path(assigns(:mm_team))
  end

  test "should destroy mm_team" do
    assert_difference('MmTeam.count', -1) do
      delete :destroy, :id => @mm_team.to_param
    end

    assert_redirected_to mm_teams_path
  end
end
