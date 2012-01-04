class BracketController < ApplicationController
  
  def index
    @bracket_entries = BracketEntry.find(:all, :order => "region_id, seed")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bracket_entrys }
    end
  end

end
