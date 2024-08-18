class AddIndexToCells < ActiveRecord::Migration[7.2]
  def change
    add_index :cells, [:grid_id, :x, :y]
  end
end
