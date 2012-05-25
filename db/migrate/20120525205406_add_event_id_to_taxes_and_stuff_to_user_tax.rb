class AddEventIdToTaxesAndStuffToUserTax < ActiveRecord::Migration
  def change
    add_column :taxes, :event_id, :integer

    add_column :user_taxes, :tax_id, :integer
    add_column :user_taxes, :user_id, :integer
  end
end
