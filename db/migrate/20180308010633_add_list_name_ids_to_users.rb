class AddListNameIdsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :listnameid, :integer, array: true, default: []
  end
end
