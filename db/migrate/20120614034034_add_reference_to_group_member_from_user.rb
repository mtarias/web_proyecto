class AddReferenceToGroupMemberFromUser < ActiveRecord::Migration
  def change
	  change_table :group_members do |t|
	    t.references :user
	    t.references :group
	  end
	end

end
