class CreateSquares < ActiveRecord::Migration[5.1]
  def change
    create_table :squares do |t|
      t.integer :game_id
      t.integer :x
      t.integer :y
      t.boolean :used
      t.boolean :bomb
      t.integer :bombs

      t.timestamps
    end
  end
end
