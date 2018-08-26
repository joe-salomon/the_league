class Common::MakeEspnApiRequest < SimpleInteractor

  expected_params :endpoint, :league_id, :year
  # required_params :endpoint

  def perform
    set_request_vars
    response = request
    check_if_valid(request)
  end

  private
  
  def set_request_vars
    endpoint   = map_endpoints[@endpoint.to_sym]
    # TODO: Return error if endpoint mapping is nil
    @path      = "/ffl/api/v2/#{endpoint}"
    @league_id = @league_id || '1310767'
    @year      = @year || Date.today.year
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
    invalid = response['error']
    if invalid
      error = invalid.first
      raise ApiExceptions::RequestError::InvalidYearError if error['message'].include?('not an valid seasonId')
      raise ApiExceptions::RequestError::InvalidLeagueError if error['message'].include?('Unable to retrieve league')
      raise ApiExceptions::RequestError
    end
    response
  end
  
  def map_endpoints
    # the repetitive mapping is for documenting open endpoints
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