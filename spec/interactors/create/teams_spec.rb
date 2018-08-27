require 'spec_helper'

describe Create::Teams do
  describe ".perform" do
    context "given a valid set of data" do
      it "creates teams with 2018 data" do
        league_data = FetchEspnApiData::Teams.perform('1310767', '2015')
        expect(Team.count).to eq(0)
        response = Create::Teams.perform(league_data)
        expect(Team.count).to eq(13)
        
        team = Team.where(profile_id: 17617955).first
        expect(team.first_name).to     eq('michael')
        expect(team.last_name).to      eq('rode')
        expect(team.user_name).to      eq('mjr442')
        expect(team.league_id).to      eq(1310767)
        expect(team.league_manager).to eq(false)
      end
      
      it "creates teams with 2015 data" do
        league_data = FetchEspnApiData::Teams.perform('1310767', '2015')
        expect(Team.count).to eq(0)
        response = Create::Teams.perform(league_data)
        
        team = Team.where(profile_id: 17617955).first
        expect(team.first_name).to     eq('michael')
        expect(team.last_name).to      eq('rode')
        expect(team.user_name).to      eq('mjr442')
        expect(team.league_id).to      eq(1310767)
        expect(team.league_manager).to eq(false)
      end
    end
  end
end