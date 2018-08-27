# == Schema Information
#
# Table name: teams
#
#  id             :bigint(8)        not null, primary key
#  first_name     :string
#  last_name      :string
#  profile_id     :bigint(8)
#  team_name      :string
#  league_manager :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Team, type: :model do
  it "saves if profile_id provided a number and unique" do
    expect(Team.count).to eq(0)
    team = Team.create(profile_id: 123456789)
    success = team.save
    expect(success).to eq(true)
    expect(Team.count).to eq(1)
  end
  
  it "fails to save if profile_id is not provided" do
    expect(Team.count).to eq(0)
    team = Team.create(first_name: 'Mike')
    success = team.save
    expect(success).to eq(false)
    expect(Team.count).to eq(0)
  end
  
  it "fails to save if profile_id is not unique" do
    expect(Team.count).to eq(0)
    team = Team.create(profile_id: 123456789)
    team.save
    team = Team.create(profile_id: 123456789)
    success = team.save
    expect(success).to eq(false)
    expect(Team.count).to eq(1)
  end
  
  it "fails to save if profile_id is not a number" do
    expect(Team.count).to eq(0)
    team = Team.create(profile_id: "1234lkj")
    success = team.save
    expect(success).to eq(false)
    expect(Team.count).to eq(0)
  end
end
