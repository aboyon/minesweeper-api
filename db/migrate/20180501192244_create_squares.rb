class CreateSquares < ActiveRecord::Migration[5.1]
  def change
    create_table :squares do |t|
      t.integer :game_id
      t.integer :x
      t.integer :y
      t.boolean :revealed, :default => false
      t.boolean :bomb, :default => false
      t.integer :bombs, :default => 0

      t.timestamps
    end
  end
end
