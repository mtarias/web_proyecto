class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :facebook_id
      t.string :twitter_id

      t.timestamps
    end
  end
end
