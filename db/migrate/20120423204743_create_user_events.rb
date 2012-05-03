class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.boolean :is_going
      t.boolean :is_admin
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :user_events, :user_id
    add_index :user_events, :event_id
  end
end
