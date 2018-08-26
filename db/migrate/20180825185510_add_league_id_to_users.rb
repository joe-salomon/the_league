class AddLeagueIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :league_id, :bigint
  end
end
