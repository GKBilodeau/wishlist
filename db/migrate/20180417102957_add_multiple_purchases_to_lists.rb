class AddMultiplePurchasesToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :multiplepurchases, :boolean, default: false
  end
end
