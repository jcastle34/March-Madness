class MmTeamsController < ApplicationController
	before_filter :user_is_admin?, :only => [:index, :edit, :new, :show, :update, :destroy]
  before_filter :verify_owner?, :only => [:preferred_players, :add_preferred_player, :remove_preferred_player]
	include DraftHelper
  include DraftExtension

  # GET /mm_teams
  # GET /mm_teams.xml
  def index
    @mm_teams = MmTeam.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mm_teams }
    end
  end

  # GET /mm_teams/1
  # GET /mm_teams/1.xml
  def show
    @mm_team = MmTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mm_team }
    end
  end

  # GET /mm_teams/new
  # GET /mm_teams/new.xml
  def new
    @mm_team = MmTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mm_team }
    end
  end

  # GET /mm_teams/1/edit
  def edit
    @mm_team = MmTeam.find(params[:id])
  end

  # POST /mm_teams
  # POST /mm_teams.xml
  def create
    @mm_team = MmTeam.new(params[:mm_team].permit(:name, :user_id))
    @mm_team.user = User.find_by(params[:user_id])

    respond_to do |format|
      if @mm_team.save
        format.html { redirect_to(@mm_team, :notice => 'Mm team was successfully created.') }
        format.xml  { render :xml => @mm_team, :status => :created, :location => @mm_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mm_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mm_teams/1
  # PUT /mm_teams/1.xml
  def update
    @mm_team = MmTeam.find(params[:id])

    respond_to do |format|
      if @mm_team.update_attributes(params[:mm_team])
        format.html { redirect_to(@mm_team, :notice => 'Mm team was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mm_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mm_teams/1
  # DELETE /mm_teams/1.xml
  def destroy
    @mm_team = MmTeam.find(params[:id])
    @mm_team.destroy

    respond_to do |format|
      format.html { redirect_to(mm_teams_url) }
      format.xml  { head :ok }
    end
  end

  def get_roster
    @mm_team = MmTeam.find params[:mm_team_id]
    @roster = @mm_team.get_players

    render :partial => "shared/mm_team_roster"
  end

  def preferred_players
      @mm_team = MmTeam.find params[:id]
      @draft = Draft.find(1)
			@draft.get_current
      @selected_round = 1
      seed_range = get_seed_ranges_by_round @selected_round
      @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
			@preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(@mm_team.id, seed_range[0], seed_range[1])
  end

  def add_preferred_player
    @mm_team = MmTeam.find(params[:id])
    @selected_round = params[:selected_round].to_i
    preferred_player = MmTeamPreferredPlayer.new(:mm_team_id => @mm_team.id, :ncaa_player_id => params[:ncaa_player_id])
    preferred_player.save
    seed_range = get_seed_ranges_by_round @selected_round
		@ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
    @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(@mm_team.id, seed_range[0], seed_range[1])
    flash[:alert] = ""
    flash[:notice] = t(:preferred_player_added)
  rescue ActiveRecord::RecordNotUnique
    seed_range = get_seed_ranges_by_round @selected_round
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
    @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(@mm_team.id, seed_range[0], seed_range[1])
    flash[:alert] = t(:preferred_player_already_added)
  end

  def remove_preferred_player
    @mm_team = MmTeam.find(params[:id])
    @selected_round = params[:selected_round].to_i
    preferred_player = MmTeamPreferredPlayer.find_by_mm_team_id_and_ncaa_player_id(params[:id], params[:ncaa_player_id])
    preferred_player.destroy
    seed_range = get_seed_ranges_by_round @selected_round
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
    @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(@mm_team.id, seed_range[0], seed_range[1])
  rescue Exception => e
    seed_range = get_seed_ranges_by_round @selected_round
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
    @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(@mm_team.id, seed_range[0], seed_range[1])
    flash[:alert] = t(:preferred_player_removal_problem)
  end

  def rosters
    @players = MmTeam.get_rosters
  end

  def get_eligible_players_by_round
    @mm_team = MmTeam.find(get_team_for_current_user)
    @selected_round = params[:selected_round]
    seed_range = get_seed_ranges_by_round @selected_round.to_i
    @ncaa_players = NcaaPlayer.get_players_by_seed_range(seed_range[0], seed_range[1])
    render "shared/get_eligible_players_by_round"
  end

  def get_preferred_players_by_round
    @mm_team = MmTeam.find(get_team_for_current_user)
    @selected_round = params[:selected_round]
    seed_range = get_seed_ranges_by_round @selected_round.to_i
    @preferred_players = NcaaPlayer.get_preferred_players_by_seed_range_for_mm_team(get_team_for_current_user, seed_range[0], seed_range[1])
    render "shared/get_preferred_players_by_round"
  end

  private

  def verify_owner?
    owner = MmTeam.find_by_id_and_user_id(params[:id], get_team_for_current_user.id)
    if(owner.nil?)
      flash[:alert] = t(:invalid_access)
      redirect_to(root_path)
    end
  end

end
