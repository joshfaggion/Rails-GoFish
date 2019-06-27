class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :started_at
      t.datetime :finished_at
      t.timestamps
      t.integer :player_count
    end
  end
end
