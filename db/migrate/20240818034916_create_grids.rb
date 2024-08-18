class CreateGrids < ActiveRecord::Migration[7.2]
  def change
    create_table :grids do |t|
      t.string :name
      t.integer :size_x
      t.integer :size_y

      t.timestamps
    end
  end
end
