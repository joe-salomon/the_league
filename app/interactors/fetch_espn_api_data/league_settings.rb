class FetchEspnApiData::LeagueSettings < SimpleInteractor
  expected_params :league_id, :year
  ENDPOINT = 'league_settings'

  def perform
    Common::MakeEspnApiRequest.perform(ENDPOINT, @league_id, @year)  
  end

end