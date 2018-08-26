require 'spec_helper'

describe FetchEspnApiData::Team do
  describe ".perform" do
    context "given a valid league_id" do
      it "returns a json response of teams with 13 teams" do
        response = FetchEspnApiData::Team.perform('1310767')
        expect(response.count).to eq(13)
      end
      
      it "returns a team with the correct attributes" do
        response = FetchEspnApiData::Team.perform('1310767')
        team = response[0]
        expect(team["firstName"]).to eq("michael")
        expect(team["lastName"]).to eq("rode")
        expect(team["isLeagueCreator"]).to eq(true)
        expect(team["inviteId"]).to eq(0)
        expect(team["teamProfileId"]).to eq(17617955)
        expect(team["isLeagueManager"]).to eq(false)
        expect(team["teamName"]).to eq("mjr442")
        expect(team["leagueId"]).to eq("1310767")
      end
      
      it "returns a team with the correct attributes" do
        response = FetchEspnApiData::Team.perform('1310767', '2015')
        team = response[0]
        expect(team["firstName"]).to eq("michael")
        expect(team["lastName"]).to eq("rode")
        expect(team["isLeagueCreator"]).to eq(true)
        expect(team["inviteId"]).to eq(0)
        expect(team["teamProfileId"]).to eq(17617955)
        expect(team["isLeagueManager"]).to eq(false)
        expect(team["teamName"]).to eq("mjr442")
        expect(team["leagueId"]).to eq("1310767")
      end
    end
    
    context "when passed an invald league id" do
      it "returns the proper error message" do
        expect{response = FetchEspnApiData::Team.perform('999999999')}.to raise_error(ApiExceptions::RequestError::InvalidLeagueError, 'This is not a valid league_id.')
      end
    end
    
    context "when passed an invalid year" do
      it "returns the proper error message" do
        expect{response = FetchEspnApiData::Team.perform('1310767', '2019')}.to raise_error(ApiExceptions::RequestError::InvalidYearError, 'This is not a valid year for this league.')
      end
    end
  end
end