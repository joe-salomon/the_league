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

class Team < ApplicationRecord
  validates :profile_id, presence: true, uniqueness: true,  numericality: {:greater_than_or_equal_to => 0}
end
