class AddIndexToGroupMembers < ActiveRecord::Migration
  def change
  	add_index :group_members, :user_id
    add_index :group_members, :group_id
  end
end
