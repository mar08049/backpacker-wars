class Travelers < ActiveRecord::Migration
  def change
    create_table :travelers do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest

    drop_table :backpackers
  end
  end
end
