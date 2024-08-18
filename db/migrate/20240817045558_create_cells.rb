class CreateCells < ActiveRecord::Migration[7.2]
  def change
    create_table :cells do |t|
      t.integer :x
      t.integer :y
      t.boolean :alive

      t.timestamps
    end
  end
end
