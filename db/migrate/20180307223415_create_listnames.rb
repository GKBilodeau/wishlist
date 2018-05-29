class CreateListnames < ActiveRecord::Migration[5.0]
  def change
    create_table :listnames do |t|
      t.string :name
      t.integer :userid
      t.integer :listitems, array: true, default: []

      t.timestamps
    end
  end
end
