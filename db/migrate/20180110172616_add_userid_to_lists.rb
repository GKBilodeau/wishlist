class AddUseridToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :userid, :integer
  end
end
