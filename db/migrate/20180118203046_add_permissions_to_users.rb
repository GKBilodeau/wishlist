class AddPermissionsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :permissions, :int, array: true, default: []
  end
end