class FetchEspnApiData::Teams < SimpleInteractor
  expected_params :league_id, :year
  ENDPOINT = 'league_settings'

  def perform
    response = Common::MakeRequest.perform(ENDPOINT, @league_id, @year) 
    schedule = Common::MakeRequest.perform('leagueSchedules', @league_id, @year) 
    get_member_info(response)
    get_total_score_for_teams(response)
  end
  
  def get_member_info(response)
    league_id = response['metadata']['leagueId']
    team_data = response['leaguesettings']['leagueMembers']
    team_data.each{|team| team['leagueId'] = league_id}
    team_data.select!{|team| team['userProfileId'].to_i > 0}
    team_data
  end
  
  def get_total_score_for_teams(response)
    teams_total_score = {}
    response['leaguesettings']['teams'].each do |team|
      matchups = team[1]['scheduleItems'].first['matchups'].each do |matchup|
        team_id = team.first
        set_matchup_scores(teams_total_score, matchup, team_id) if matchup['awayTeamScores']
      end
    end  
  end
  
  def set_matchup_scores(teams_total_score, matchup, team_id)
    home_team                  = is_home_team?(matchup, team_id)
    points_for                 = home_team ? matchup['homeTeamScores'].first : matchup['awayTeamScores'].first
    points_against             = home_team ? matchup['awayTeamScores'].first : matchup['homeTeamScores'].first
    teams_total_score[team_id] = {'points_for': points_for, 'points_against': points_against} 
  end
  
  def is_home_team?(matchup, team_id)
    true if team_id == matchup['homeTeamId'].to_s
  end
end