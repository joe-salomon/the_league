class Standings < SimpleInteractor

  expected_params :year
  LEAGUE_ID = '1310767'
  ENDPOINT = "http://games.espn.com/ffl/standings?leagueId=#{LEAGUE_ID}&seasonId=#{@year}"

  def perform
    request
  end

  private

  def request
    Nokogiri::HTML(open(ENDPOINT)) 
  end

end