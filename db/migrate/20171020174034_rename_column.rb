class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :countries, :user_id, :user_id
  end
end
