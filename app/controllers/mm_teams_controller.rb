class MmTeamsController < ApplicationController
  before_filter :verify_owner?, :only => [:preferred_players, :add_preferred_player, :remove_preferred_player]
  before_filter :rosters_locked?, :only => [:add_preferred_player, :remove_preferred_player]
	include DraftHelper
  include DraftExtension

  def new
    @mm_team = MmTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mm_team }
    end
  end

  def create
    @mm_team = MmTeam.new(params[:mm_team])
    @mm_team.user = User.find(current_user.id)

    respond_to do |format|
      if @mm_team.save
        format.html { redirect_to(home_index_url, :notice => t(:mm_team_created)) }
        format.xml  { render :xml => @mm_team, :status => :created, :location => @mm_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mm_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  def get_roster
    @mm_team = MmTeam.find params[:mm_team_id]
    @roster = @mm_team.get_preferred_players

    render :partial => "shared/mm_team_roster"
  end

  def my_roster
    @mm_team = MmTeam.find params[:id]
    @roster = @mm_team.get_preferred_players
  end

  def preferred_players
      @mm_team = MmTeam.find params[:id]
      @selected_position = 'G'
      @sort = 'seed'
      @sort_order = 'asc'
      @ncaa_players = NcaaPlayer.get_players_by_position(@selected_position, @sort, @sort_order)
			@preferred_players = NcaaPlayer.get_preferred_players_for_mm_team(@mm_team.id)
      @player_seed_total = @mm_team.get_players_seed_total(params[:id])
  end

  def add_preferred_player
    @mm_team = MmTeam.find(params[:id])
    player_id_to_add = params[:ncaa_player_id]
    preferred_player = MmTeamPreferredPlayer.new
    result = preferred_player.add(params[:id], player_id_to_add)
		if preferred_player.errors.empty?
      flash[:notice] = t(:preferred_player_added)
    else
      flash[:alert] = preferred_player.errors.full_messages.to_sentence
    end

    @ncaa_players = NcaaPlayer.get_players_by_seed_range(1, 16)
    @preferred_players = NcaaPlayer.get_preferred_players_for_mm_team(@mm_team.id)
    @player_seed_total = @mm_team.get_players_seed_total(params[:id])
  end

  def remove_preferred_player
    @mm_team = MmTeam.find(params[:id])
    preferred_player = MmTeamPreferredPlayer.find_by_mm_team_id_and_ncaa_player_id(params[:id], params[:ncaa_player_id])
    preferred_player.destroy
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(1, 16)
    @preferred_players = NcaaPlayer.get_preferred_players_for_mm_team(@mm_team.id)
    @player_seed_total = @mm_team.get_players_seed_total(params[:id])
    flash[:notice] = t(:preferred_player_removed)
  rescue Exception => e
    flash[:alert] = t(:preferred_player_removal_problem)
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(1, 16)
    @preferred_players = NcaaPlayer.get_preferred_players_for_mm_team(@mm_team.id)
    @player_seed_total = @mm_team.get_players_seed_total(params[:id])
  end

  def rosters
    @players = MmTeam.get_all_rosters
  end

  def get_eligible_players_by_round
    @mm_team = MmTeam.find(get_team_for_current_user)
    @selected_round = params[:selected_round]
    seed_range = get_seed_ranges_by_round @selected_round.to_i
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
    render "shared/get_eligible_players_by_round"
  end

  def get_eligible_players_by_position
    @mm_team = MmTeam.find(get_team_for_current_user)
    @selected_position = params[:selected_position]
    @sort = params[:sort]
    @sort_order = params[:sort_order]
    
    @ncaa_players = NcaaPlayer.get_players_by_position(@selected_position, @sort, @sort_order)
    render "shared/get_eligible_players_by_round"
  end

  def sort_eligible_players
    @mm_team = MmTeam.find(get_team_for_current_user)
    @selected_position = params[:selected_position]
    @sort = params[:sort]
    @sort_order = params[:sort_order]

    if @sort_order == 'asc'
      @sort_order = 'desc'
    else
      @sort_order = 'asc'
    end
    
    @ncaa_players = NcaaPlayer.get_players_by_position(@selected_position, @sort, @sort_order)
    render "shared/get_eligible_players_by_round"
  end

  def get_preferred_players_by_round
    @mm_team = MmTeam.find(get_team_for_current_user)
    @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(get_team_for_current_user, 1, 16)
    render "shared/get_preferred_players_by_round"
  end

  private

  def verify_owner?
    owner = MmTeam.find_by_id_and_user_id(params[:id], current_user.id )
    if(owner.nil?)
      flash[:alert] = t(:invalid_access)
      redirect_to(root_path)
    end
  end

  def rosters_locked?
    if(Draft.is_completed?)
      flash[:alert] = t(:rosters_locked)
      render js: "window.location = '#{my_roster_mm_team_path}'"
    end
  end

end
