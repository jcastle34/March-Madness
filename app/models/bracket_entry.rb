class BracketEntry < ActiveRecord::Base
  belongs_to :ncaa_team
  belongs_to :region
  
  SEEDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
end
