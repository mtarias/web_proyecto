class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.boolean :is_admin
      t.boolean :is_going

      t.timestamps
    end
  end
end
