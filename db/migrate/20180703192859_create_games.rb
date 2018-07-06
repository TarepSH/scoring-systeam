class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :game_point
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
