class AddGuests < ActiveRecord::Migration
  def up
  	drop_table :user_events
  	drop_table :event_comments
  end

  def down
  	
  end
end
