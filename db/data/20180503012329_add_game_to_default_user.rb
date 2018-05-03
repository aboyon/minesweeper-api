class AddGameToDefaultUser < SeedMigration::Migration
  def up
    Game.create(:rows => 4, :cols => 4, :bombs => 2, :user => User.first)
  end

  def down

  end
end
