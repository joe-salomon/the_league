require 'spec_helper'

describe FetchEspnApiData::LeagueSettings do
  describe ".perform" do
    context "given a valid league_id" do
      it "returns a json response of league settings" do
        FetchEspnApiData::LeagueSettings.perform('1310767')
      end
      
    end
    
    context "given an invalid set of data" do
    
    end
  end
end