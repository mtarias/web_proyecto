class DropTable < ActiveRecord::Migration
  def up
  	drop_table :event_comments 
  end

  def down
  end
end
