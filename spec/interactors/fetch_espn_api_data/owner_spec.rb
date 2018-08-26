# require 'spec_helper'
# 
# describe FetchEspnApiData::Owner do
#   describe ".perform" do
#     context "given a valid league_id" do
#       it "returns a json response of owners" do
#         response = FetchEspnApiData::League.perform('1310767')
#         binding.pry
#         expect(response.count).to eq(13)
#       end
#       
#       it "returns a team with the correct attributes" do
#         response = FetchEspnApiData::Team.perform('1310767')
#         team = response[0]
#         expect(team["firstName"]).to eq("michael")
#         expect(team["lastName"]).to eq("rode")
#         expect(team["isLeagueCreator"]).to eq(true)
#         expect(team["inviteId"]).to eq(0)
#         expect(team["TeamProfileId"]).to eq(17617955)
#         expect(team["isLeagueManager"]).to eq(false)
#         expect(team["TeamName"]).to eq("mjr442")
#         expect(team["leagueId"]).to eq("1310767")
#       end 
#     end
#   end
# end