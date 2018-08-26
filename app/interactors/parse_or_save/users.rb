class ParseOrSave::Users < SimpleInteractor

  expected_params :league_data, :save

  def perform
    return response if invalid_league_data?  
    symbolize_keys
    parse_league_members
    find_or_create_users if @save
    response
  end

  private

  def parse_league_members
    @league_members = @league_data[:leaguesettings][:leagueMembers]
  end
  
  def find_or_create_users
    @new_user_count = 0
    @league_members.each{|member| find_or_create_user(member)}
  end
  
  def find_or_create_user(member)
    user = User.find_or_create_by(profile_id: member[:userProfileId]) do |user|
      user.first_name     = member[:firstName]
      user.last_name      = member[:lastName]
      user.user_name      = member[:userName]
      user.league_manager = member[:isLeagueManager]
      user.league_id      = @league_data[:metadata][:leagueId]
      success = user.save
      @new_user_count += 1 if success
    end
  end
  
  def symbolize_keys
    @league_data.deep_symbolize_keys!
  end
  
  def response
    {code: @code || 200, message: @message || @league_members}
  end
  
  def invalid_league_data?
    if @league_data['error'].present?
      @code = 201
      @message = 'You have passed invalid league data. please check that the league_id and year are correct.'
    end
    @league_data['error'].present?
  end
  
end