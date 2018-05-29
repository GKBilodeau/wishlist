class AddListNameIdToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :listnameid, :integer
  end
end
