module Api
  class UsersController < ApplicationController
    
    before_action :set_user, only: [:show]
    before_action :set_league_id, :set_year_id

    def index
      response = Common::MakeEspnApiRequest.perform('league_settings', @league_id, @year)
      response = response['leaguesettings']['leagueMembers'] if response.success?
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
