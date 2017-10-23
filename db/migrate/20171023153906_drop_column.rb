class DropColumn < ActiveRecord::Migration
  def down
    remove_column :backpackers, :name
  end
end
