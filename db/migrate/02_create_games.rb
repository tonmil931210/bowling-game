class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer    :players
      t.string     :winner
      t.integer    :turn, default: 1
      t.timestamps
    end
  end
end
