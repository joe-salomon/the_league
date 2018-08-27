module Api
  class TeamsController < ApplicationController
    before_action :set_league_id, :set_year_id

    def index
      response = FetchEspnApiData::Teams.perform(@league_id, @year)
      json_response response
    end
    
    private
    
    def set_league_id
      @league_id = params[:league_id]
    end
    
    def set_year_id
      @year = params[:year]
    end
  end
end
