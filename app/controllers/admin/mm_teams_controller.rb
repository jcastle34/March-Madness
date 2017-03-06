class Admin::MmTeamsController < ApplicationController
	before_filter :user_is_admin?, :only => [:index, :edit, :new, :show, :update, :destroy]

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
        format.html { redirect_to(admin_mm_teams_url, :notice => 'Mm team was successfully created.') }
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
        format.html { redirect_to(admin_mm_teams_url, :notice => 'Mm team was successfully updated.') }
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
      format.html { redirect_to(admin_mm_teams_url) }
      format.xml  { head :ok }
    end
  end
end
