# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create the Draft
Draft.create(:total_rounds => 6, :total_teams => 20)

# Create MM Teams
MmTeam.create(:name => 'Team 1', :year => Time.new.year)
MmTeam.create(:name => 'Team 2', :year => Time.new.year)
MmTeam.create(:name => 'Team 3', :year => Time.new.year)
MmTeam.create(:name => 'Team 4', :year => Time.new.year)
MmTeam.create(:name => 'Team 5', :year => Time.new.year)
MmTeam.create(:name => 'Team 6', :year => Time.new.year)
MmTeam.create(:name => 'Team 7', :year => Time.new.year)
MmTeam.create(:name => 'Team 8', :year => Time.new.year)
MmTeam.create(:name => 'Team 9', :year => Time.new.year)
MmTeam.create(:name => 'Team 10', :year => Time.new.year)
MmTeam.create(:name => 'Team 11', :year => Time.new.year)
MmTeam.create(:name => 'Team 12', :year => Time.new.year)
MmTeam.create(:name => 'Team 13', :year => Time.new.year)
MmTeam.create(:name => 'Team 14', :year => Time.new.year)
MmTeam.create(:name => 'Team 15', :year => Time.new.year)
MmTeam.create(:name => 'Team 16', :year => Time.new.year)
MmTeam.create(:name => 'Team 17', :year => Time.new.year)
MmTeam.create(:name => 'Team 18', :year => Time.new.year)
MmTeam.create(:name => 'Team 19', :year => Time.new.year)
MmTeam.create(:name => 'Team 20', :year => Time.new.year)

## Create the Regions
Region.create(:location => 'East')
Region.create(:location => 'Midwest')
Region.create(:location => 'South')
Region.create(:location => 'West')

