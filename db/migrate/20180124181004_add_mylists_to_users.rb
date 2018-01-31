class AddMylistsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mylists, :int, array: true, default: []
  end
end
