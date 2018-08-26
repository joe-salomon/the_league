class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.bigint :profile_id
      t.string :user_name
      t.boolean :league_manager

      t.timestamps
    end
  end
end
