class NcaaTeamsController < ApplicationController
	
  def rosters
    @ncaa_teams = NcaaTeam.get_rosters

    respond_to do |format|
      format.html
      format.xml  { render :xml => @ncaa_teams }
    end
  end
end
