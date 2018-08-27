class CreateFrameByUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :frame_by_users do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :final_score, default: 0

      t.timestamps
    end
  end
end
