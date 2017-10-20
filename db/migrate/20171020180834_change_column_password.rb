class ChangeColumnPassword < ActiveRecord::Migration
  def change
    rename_column :travelers, :password, :password_digest
  end
end
