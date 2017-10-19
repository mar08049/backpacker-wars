class Countries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
