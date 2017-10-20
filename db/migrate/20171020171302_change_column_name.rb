class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :travelers, :password_digest, :password
  end
end
