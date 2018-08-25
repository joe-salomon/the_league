require 'spec_helper'

describe ParseAndSave::Users do
  describe ".perform" do
    context "given a valid set of data" do
      it "creates users" do
        league_data = LoadLeague.perform('2018')
        expect(User.count).to eq(0)
        response = ParseAndSave::Users.perform(league_data)
        expect(User.count).to eq(14)
        expect(response[:code]).to eq(200)
        expect(response[:message]).to eq('14 users were created.')
        
        user = User.where(profile_id: 17617955).first
        expect(user.first_name).to     eq('michael')
        expect(user.last_name).to      eq('rode')
        expect(user.user_name).to      eq('mjr442')
        expect(user.league_manager).to eq(false)
      end
    end
    
    context "given an invalid set of data" do
      it "fails to create users" do
        league_data = LoadLeague.perform('2019')
        expect(User.count).to eq(0)
        response = ParseAndSave::Users.perform(league_data)
        expect(User.count).to eq(0)
        expect(response[:code]).to eq(201)
        expect(response[:message]).to eq('You have passed invalid league data. please check that the league_id and year are correct.')
      end
    end
  end
end