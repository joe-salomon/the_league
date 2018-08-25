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

class User < ApplicationRecord
  validates :profile_id, presence: true, uniqueness: true,  numericality: { only_integer: true }
end
