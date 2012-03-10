class BracketController < ApplicationController
  
  def index
    @bracket_entries = BracketEntry.find(:all, :order => "region_id, seed")
  end

  def update_region
    raise params.inspect
  end

end
