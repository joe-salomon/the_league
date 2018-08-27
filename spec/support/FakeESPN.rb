require 'sinatra/base'
require 'pry'

class FakeESPN < Sinatra::Base
  get '/ffl/api/v2/leagueSettings?' do
    if request.params == {"leagueId"=>"1310767", "seasonId"=>"2018"}  
      get_response('settings_2018.json', 'league_settings')
    elsif request.params == {"leagueId"=>"1310767", "seasonId"=>"2015"}  
      get_response('settings_2015.json', 'league_settings')
    elsif request.params == {"leagueId"=>"1310767", "seasonId"=>"2019"}
      get_response 'invalid_year.json', 'league_settings'
    elsif request.params == {"leagueId"=>"999999999", "seasonId"=>"2018"}
      get_response('invalid_league.json', 'league_settings')
    else 
      get_response('404_response.html','league_settings')
    end
  end
  
  get '/ffl/api/v2/leagueSchedules?' do
    if request.params == {"leagueId"=>"1310767", "seasonId"=>"2015"}  
      get_response('schedules_2016.json', 'league_schedules')
    else
      get_response('404_response.html','league_settings')
    end
  end

  private

  def get_response(file_name, folder_name)
    content_type :json
    response = File.open(File.dirname(__FILE__) + "/fixtures/#{folder_name}/" + file_name, 'rb').read
  end
end