class AddIndexToGroup < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.references :user
    end
    add_index :groups, :user_id
  end
end
