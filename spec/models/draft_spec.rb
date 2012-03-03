require 'spec_helper'


describe Draft do
  let(:create_mm_team){MmTeam.new(:id => 1)}

  it "should be a valid object" do
    draft = Draft.new
    draft.should be_valid
  end

  describe "roster_valid?" do
    it "should be invalid when 4 positions are forwards" do
      3.times do
        player = NcaaPlayer.new(:position => NcaaPlayer::FORWARD)
        create_mm_team.ncaa_players << player
      end

      MmTeam.expects(:find).with(create_mm_team.id).returns(create_mm_team)
      MmTeam.any_instance.expects(:get_players).returns(create_mm_team.ncaa_players)

      draft = Draft.new
      draft.send(:roster_valid?, create_mm_team.id, NcaaPlayer::FORWARD).should eq(false)
    end

    it "should be invalid when 4 positions are guards" do
      3.times do
        player = NcaaPlayer.new(:position => NcaaPlayer::GUARD)
        create_mm_team.ncaa_players << player
      end

      MmTeam.expects(:find).with(create_mm_team.id).returns(create_mm_team)
      MmTeam.any_instance.expects(:get_players).returns(create_mm_team.ncaa_players)

      draft = Draft.new
      draft.send(:roster_valid?, create_mm_team.id, NcaaPlayer::GUARD).should eq(false)
    end

    it "should be invalid when 3 positions are centers" do
      3.times do
        player = NcaaPlayer.new(:position => NcaaPlayer::CENTER)
        create_mm_team.ncaa_players << player
      end

      MmTeam.expects(:find).with(create_mm_team.id).returns(create_mm_team)
      MmTeam.any_instance.expects(:get_players).returns(create_mm_team.ncaa_players)

      draft = Draft.new
      draft.send(:roster_valid?, create_mm_team.id, NcaaPlayer::CENTER).should eq(false)
    end

    it "should be valid when positions are 2 guards, 3 forwards, one center" do
      2.times do
        player = NcaaPlayer.new(:position => NcaaPlayer::GUARD)
        create_mm_team.ncaa_players << player
      end

      3.times do
        player = NcaaPlayer.new(:position => NcaaPlayer::FORWARD)
        create_mm_team.ncaa_players << player
      end

      player = NcaaPlayer.new(:position => NcaaPlayer::CENTER)
      create_mm_team.ncaa_players << player

      MmTeam.expects(:find).with(create_mm_team.id).returns(create_mm_team)
      MmTeam.any_instance.expects(:get_players).returns(create_mm_team.ncaa_players)

      draft = Draft.new
      draft.send(:roster_valid?, create_mm_team.id, NcaaPlayer::CENTER).should eq(true)
      create_mm_team.ncaa_players.size.should eq(6)
    end

    it "should be invalid if the center position is not part of a full roster" do
      3.times do
        player = NcaaPlayer.new(:position => NcaaPlayer::GUARD)
        create_mm_team.ncaa_players << player
      end

      2.times do
        player = NcaaPlayer.new(:position => NcaaPlayer::FORWARD)
        create_mm_team.ncaa_players << player
      end

      MmTeam.expects(:find).with(create_mm_team.id).returns(create_mm_team)
      MmTeam.any_instance.expects(:get_players).returns(create_mm_team.ncaa_players)

      draft = Draft.new
      draft.send(:roster_valid?, create_mm_team.id, NcaaPlayer::GUARD).should eq(false)
    end
  end
end