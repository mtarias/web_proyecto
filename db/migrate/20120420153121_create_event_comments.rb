class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
      t.string :comment

      t.timestamps
    end
  end
end
