class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :countries, :user_id, :traveler_id
  end
end
