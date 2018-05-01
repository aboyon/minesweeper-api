class AddDefaultUser < SeedMigration::Migration
  def up
    User.create(:name => 'Default User', :email => 'jdsilveira@gmail.com', :password => '!Password123.')
  end

  def down

  end
end
