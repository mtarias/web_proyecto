class CreateUserTaxes < ActiveRecord::Migration
  def change
    create_table :user_taxes do |t|
      t.int :amount_user

      t.timestamps
    end
  end
end
