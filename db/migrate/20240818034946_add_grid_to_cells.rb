class AddGridToCells < ActiveRecord::Migration[7.2]
  def change
    add_reference :cells, :grid, null: false, foreign_key: true
  end
end
