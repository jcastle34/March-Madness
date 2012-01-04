class NcaaTeamsController < ApplicationController
	before_filter :user_is_admin?
	
  # GET /ncaa_teams
  # GET /ncaa_teams.xml
  def index
    @ncaa_teams = NcaaTeam.order('school asc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ncaa_teams }
    end
  end

  # GET /ncaa_teams/1
  # GET /ncaa_teams/1.xml
  def show
    @ncaa_team = NcaaTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ncaa_team }
    end
  end

  # GET /ncaa_teams/new
  # GET /ncaa_teams/new.xml
  def new
    @ncaa_team = NcaaTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ncaa_team }
    end
  end

  # GET /ncaa_teams/1/edit
  def edit
    @ncaa_team = NcaaTeam.find(params[:id])
  end

  # POST /ncaa_teams
  # POST /ncaa_teams.xml
  def create
    @ncaa_team = NcaaTeam.new(params[:ncaa_team])

    respond_to do |format|
      if @ncaa_team.save
        format.html { redirect_to(@ncaa_team, :notice => 'Ncaa team was successfully created.') }
        format.xml  { render :xml => @ncaa_team, :status => :created, :location => @ncaa_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ncaa_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ncaa_teams/1
  # PUT /ncaa_teams/1.xml
  def update
    @ncaa_team = NcaaTeam.find(params[:id])

    respond_to do |format|
      if @ncaa_team.update_attributes(params[:ncaa_team])
        format.html { redirect_to(@ncaa_team, :notice => 'Ncaa team was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ncaa_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ncaa_teams/1
  # DELETE /ncaa_teams/1.xml
  def destroy
    @ncaa_team = NcaaTeam.find(params[:id])
    @ncaa_team.destroy

    respond_to do |format|
      format.html { redirect_to(ncaa_teams_url) }
      format.xml  { head :ok }
    end
  end
end
