class AddLeagueIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :league_id, :bigint
  end
end
