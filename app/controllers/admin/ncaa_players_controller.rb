class Admin::NcaaPlayersController < ApplicationController
	before_filter :user_is_admin?
	
  # GET /ncaa_players
  # GET /ncaa_players.xml
  def index
    @ncaa_players = NcaaPlayer.joins('join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id').order('nt.school asc, ncaa_players.position desc')  
      
    respond_to do |format|
    	format.html # index.html.erb
     	format.xml  { render :xml => @ncaa_players }
    end
  end
  
  def get_by_ncaa_team
			@selected_team_id = params[:ncaa_team_id]
			if @selected_team_id.nil? || @selected_team_id == ''
					@ncaa_players = NcaaPlayer.joins('join ncaa_teams nt on nt.id = ncaa_players.ncaa_team_id').order('nt.school asc, ncaa_players.position desc')  
      else
					@ncaa_players = NcaaPlayer.where(:ncaa_team_id => @selected_team_id)
			end
  end

  # GET /ncaa_players/1
  # GET /ncaa_players/1.xml
  def show
    @ncaa_player = NcaaPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ncaa_player }
    end
  end

  # GET /ncaa_players/new
  # GET /ncaa_players/new.xml
  def new
    @ncaa_player = NcaaPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ncaa_player }
    end
  end

  # GET /ncaa_players/1/edit
  def edit
    @ncaa_player = NcaaPlayer.find(params[:id])
  end

  # POST /ncaa_players
  # POST /ncaa_players.xml
  def create
    @ncaa_player = NcaaPlayer.new(params[:ncaa_player])

    respond_to do |format|
      if @ncaa_player.save
        format.html { redirect_to([:admin, @ncaa_player], :notice => 'Ncaa player was successfully created.') }
        format.xml  { render :xml => @ncaa_player, :status => :created, :location => @ncaa_player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ncaa_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ncaa_players/1
  # PUT /ncaa_players/1.xml
  def update
    @ncaa_player = NcaaPlayer.find(params[:id])

    respond_to do |format|
      if @ncaa_player.update_attributes(params[:ncaa_player])
        format.html { redirect_to(admin_ncaa_players_url, :notice => 'Ncaa player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ncaa_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ncaa_players/1
  # DELETE /ncaa_players/1.xml
  def destroy
    @ncaa_player = NcaaPlayer.find(params[:id])
    @ncaa_player.destroy

    respond_to do |format|
      format.html { redirect_to(admin_ncaa_players_url) }
      format.xml  { head :ok }
    end
  end
end
