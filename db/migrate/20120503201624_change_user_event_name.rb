class ChangeUserEventName < ActiveRecord::Migration
  def up
  	rename_table :user_events, :guests
  end

  def down
  	rename_table :guests, :user_events
  end
end
