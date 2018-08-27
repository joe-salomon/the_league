class Common::MakeRequest < SimpleInteractor

  expected_params :endpoint, :league_id, :year
  # required_params :endpoint

  def perform
    set_request_vars
    check_if_valid(request)
  end

  private
  
  def set_request_vars
    endpoint   = map_endpoints[@endpoint.to_sym]
    @path      = "/ffl/api/v2/#{endpoint}"
    @league_id = @league_id
    @year      = @year
  end
  
  def build_uri
    URI::HTTP.build(
      host: 'games.espn.com', 
      path: @path, 
      query: { leagueId: @league_id, seasonId: @year }.to_query
    )
  end
  
  def request
    HTTParty.get(build_uri)
  end
  
  def check_if_valid(response)
    error = response['error']
    raise_error(error.first) if error
    response
  end
  
  def raise_error(error)
    raise ApiExceptions::RequestError::InvalidYearError   if error['message'].include?('not an valid seasonId')
    raise ApiExceptions::RequestError::InvalidLeagueError if error['message'].include?('Unable to retrieve league')
    raise ApiExceptions::RequestError::PrivateLeagueError if error['message'].include?('No permission to view this league')
  end
  
  def map_endpoints
    {
      player_news: 'player/news',
      recent_activity: 'recentActivity',
      league_schedules: 'leagueSchedules',
      teams: 'teams',
      roster_info: 'rosterInfo',
      schedule: 'schedule',
      polls: 'polls',
      messageboard: 'messageboard',
      stories: 'stories',
      teams_pending_move_batches: 'teams/pendingMoveBatches',
      league_settings: 'leagueSettings'
    }
  end
end