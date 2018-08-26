class TeamsController < ApplicationController
  
  before_action :set_team, only: [:show]
  before_action :set_league_id, :set_year

  def index
    league_data = FetchEspnApiData::Teams.perform(@league_id, @year) 
    Create::Teams.perform(league_data)
    @teams = Team.where(league_id: @league_id)
    json_response @teams
  end
  
  def show
    json_response @team  
  end
  
  private
  
  def set_team
    @team = Team.find(params[:id])
  end
  
  def set_year
    @year = params[:year]
  end
  def set_league_id
    @league_id = params[:league_id]
  end
end
