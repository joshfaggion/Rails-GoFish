class AddColumnToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :go_fish, :jsonb, null: false, default: {}
  end
end
