class AddBombsRowsColsToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :bombs, :integer, :default => 0
    add_column :games, :cols, :integer
    add_column :games, :rows, :integer
  end
end
