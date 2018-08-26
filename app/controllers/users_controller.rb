class UsersController < ApplicationController
  
  before_action :set_user, only: [:show]
  before_action :set_league_id

  def index
    league_data = LoadLeague.perform(Date.today.year, @league_id)
    ParseOrSave::Users.perform(league_data)
    @users = User.where(league_id: @league_id)
    json_response @users
  end
  
  def show
    json_response @user  
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def set_league_id
    @league_id = params[:league_id]
  end
end
