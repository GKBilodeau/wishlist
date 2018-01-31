class AddPurchasedbyToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :purchasedby, :integer
  end
end
