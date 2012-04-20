class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :place
      t.text :description
      t.boolean :is_private

      t.timestamps
    end
  end
end
