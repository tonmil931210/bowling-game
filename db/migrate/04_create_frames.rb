class CreateFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.references :frame_by_user, foreign_key: true
      t.integer :try1
      t.integer :try2
      t.integer :try3
      t.integer :score
      t.integer :turn
      t.string :status
      t.timestamps
    end
  end
end
