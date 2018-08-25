require 'spec_helper'
require 'pry'

describe LoadLeague do
  describe ".perform" do
    context "given a valid league year" do
      it "returns a hash of league data with a 200 response" do
        response = LoadLeague.perform('2018')
        
        expect(response.code).to eq(200)
        expect(response.success?).to eq(true)
        expect(response['leaguesettings']).to be_an(Hash)
        
      end
    end
    context "given an invalid league year" do
      it "returns a hash of league data with a 200 response" do
        response = LoadLeague.perform('2019')
        
        expect(response.code).to eq(201)
        expect(response['error'][0]['code']).to eq('functional')
        expect(response['error'][0]['message']).to eq('Error reading param: seasonId (not an valid seasonId)')
        
      end
    end
  end
end