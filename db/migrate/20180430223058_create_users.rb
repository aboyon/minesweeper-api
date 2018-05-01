class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.text :password_digest
      t.string :name
      t.string :session_token

      t.timestamps
    end
  end
end
