class Create::Teams < SimpleInteractor

  expected_params :league_data

  def perform
    find_or_create_teams
  end

  private
  
  def find_or_create_teams
    @new_team_count = 0
    @league_data.each{|member| find_or_create_team(member)}
  end
  
  def find_or_create_team(member)
    team = Team.find_or_create_by(profile_id: member['teamProfileId']) do |team|
      team.first_name     = member['firstName']
      team.last_name      = member['lastName']
      team.user_name      = member['teamName']
      team.league_manager = member['isLeagueManager']
      team.league_id      = member['leagueId']
      success = team.save
      @new_team_count += 1 if success
    end
  end
end