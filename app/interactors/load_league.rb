class LoadLeague < SimpleInteractor

  expected_params :year

  ENDPOINT = 'http://games.espn.com/ffl/api/v2/leagueSettings'
  LEAGUE_ID = '1310767'

  def perform
    @params = { query: { leagueId: LEAGUE_ID, seasonId: @year } }
    request
  end

  private

  def request
    HTTParty.get(ENDPOINT, @params)
  end

end