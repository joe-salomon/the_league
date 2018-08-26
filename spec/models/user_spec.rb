# == Schema Information
#
# Table name: users
#
#  id             :bigint(8)        not null, primary key
#  first_name     :string
#  last_name      :string
#  profile_id     :bigint(8)
#  user_name      :string
#  league_manager :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it "saves if profile_id provided a number and unique" do
    expect(User.count).to eq(0)
    user = User.create(profile_id: 123456789)
    success = user.save
    expect(success).to eq(true)
    expect(User.count).to eq(1)
  end
  
  it "fails to save if profile_id is not provided" do
    expect(User.count).to eq(0)
    user = User.create(first_name: 'Mike')
    success = user.save
    expect(success).to eq(false)
    expect(User.count).to eq(0)
  end
  
  it "fails to save if profile_id is not unique" do
    expect(User.count).to eq(0)
    user = User.create(profile_id: 123456789)
    user.save
    user = User.create(profile_id: 123456789)
    success = user.save
    expect(success).to eq(false)
    expect(User.count).to eq(1)
  end
  
  it "fails to save if profile_id is not a number" do
    expect(User.count).to eq(0)
    user = User.create(profile_id: "1234lkj")
    success = user.save
    expect(success).to eq(false)
    expect(User.count).to eq(0)
  end
end
