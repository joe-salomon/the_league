require 'spec_helper'

describe ParseOrSave::Teams do
  describe ".perform" do
    context "given a valid set of data" do
      it "creates teams with 2018 data" do
        league_data = LoadLeague.perform('2018')
        expect(Team.count).to eq(0)
        response = ParseOrSave::Teams.perform(league_data, true)
        expect(Team.count).to eq(13)
        expect(response[:code]).to eq(200)
        expect(response[:message].size).to eq(14)
        
        team = Team.where(profile_id: 17617955).first
        expect(team.first_name).to     eq('michael')
        expect(team.last_name).to      eq('rode')
        expect(team.user_name).to      eq('mjr442')
        expect(team.league_id).to      eq(1310767)
        expect(team.league_manager).to eq(false)
      end
      
      it "creates teams with 2015 data" do
        league_data = LoadLeague.perform('2015')
        expect(Team.count).to eq(0)
        response = ParseOrSave::Teams.perform(league_data, true)
        expect(Team.count).to eq(13)
        expect(response[:code]).to eq(200)
        expect(response[:message].size).to eq(13)
        
        team = Team.where(profile_id: 17617955).first
        expect(team.first_name).to     eq('michael')
        expect(team.last_name).to      eq('rode')
        expect(team.user_name).to      eq('mjr442')
        expect(team.league_id).to      eq(1310767)
        expect(team.league_manager).to eq(false)
      end
    end
    
    context "given an invalid set of data" do
      it "fails to create teams" do
        league_data = LoadLeague.perform('2019')
        expect(Team.count).to eq(0)
        response = ParseOrSave::Teams.perform(league_data)
        expect(Team.count).to eq(0)
        expect(response[:code]).to eq(201)
        expect(response[:message]).to eq('You have passed invalid league data. please check that the league_id and year are correct.')
      end
    end
  end
end