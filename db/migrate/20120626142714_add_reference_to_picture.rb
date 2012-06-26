class AddReferenceToPicture < ActiveRecord::Migration
    def change
	  change_table :pictures do |t|
	    t.references :user
	    t.references :event
	  end
	add_column :pictures, :is_avatar , :boolean
	add_index :pictures, :user_id
    add_index :pictures, :event_id
	end
end
