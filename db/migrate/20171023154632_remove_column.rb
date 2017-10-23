class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :travelers, :name
  end
end
