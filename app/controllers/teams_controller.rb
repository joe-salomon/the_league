class TeamsController < ApplicationController
  
  before_action :set_team, only: [:show]
  before_action :set_league_id

  def index
    league_data = LoadLeague.perform(Date.today.year, @league_id)
    ParseOrSave::Teams.perform(league_data)
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
  
  def set_league_id
    @league_id = params[:league_id]
  end
end
