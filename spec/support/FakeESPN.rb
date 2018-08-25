require 'sinatra/base'
require 'pry'

class FakeESPN < Sinatra::Base
  get '/ffl/api/v2/leagueSettings?' do
    if request.params == {"leagueId"=>"1310767", "seasonId"=>"2018"}  
      json_response 200, 'valid_league_2018.json'
    elsif request.params == {"leagueId"=>"1310767", "seasonId"=>"2015"}  
      json_response 200, 'valid_league_2015.json'
    elsif request.params == {"leagueId"=>"1310767", "seasonId"=>"2019"}
      json_response 201, 'invalid_league.json'
    end
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end