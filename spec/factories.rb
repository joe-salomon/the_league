FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    profile_id { Faker::Number.number(10) }
    user_name { Faker::Internet.username(first_name)}
    league_manager false
  end
end
