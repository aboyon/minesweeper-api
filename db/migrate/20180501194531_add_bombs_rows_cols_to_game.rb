class AddBombsRowsColsToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :bombs, :integer
    add_column :games, :cols, :integer
    add_column :games, :rows, :integer
  end
end
