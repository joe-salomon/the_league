class FetchEspnApiData::Teams < SimpleInteractor
  expected_params :league_id, :year
  ENDPOINT = 'league_settings'

  def perform
    response = Common::MakeRequest.perform(ENDPOINT, @league_id, @year) 
    format_data(response)
  end
  
  def format_data(response)
    league_id = response['metadata']['leagueId']
    team_data = response['leaguesettings']['leagueMembers']
    team_data.each{|team| team['leagueId'] = league_id}
    team_data.select!{|team| team['userProfileId'].to_i > 0}
    team_data
  end
end