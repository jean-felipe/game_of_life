# == Schema Information
#
# Table name: cells
#
#  id         :integer          not null, primary key
#  alive      :boolean
#  x          :integer
#  y          :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  grid_id    :integer          not null
#
# Indexes
#
#  index_cells_on_grid_id  (grid_id)
#
# Foreign Keys
#
#  grid_id  (grid_id => grids.id)
#
class Cell < ApplicationRecord
  belongs_to :grid

  # Returns the neighboring cells
  def neighbors
    Cell.where(
      grid_id: grid_id,
      x: (x-1..x+1),
      y: (y-1..y+1)
    ).where.not(id: id)
  end

  # Returns the number of alive neighbors
  def alive_neighbors
    neighbors.where(alive: true).count
  end

  # Updates the state of the cell based on the Game of Life rules
  def update_state
    alive_count = alive_neighbors

    if alive?
      self.alive = false if alive_count < 2 || alive_count > 3
    else
      self.alive = true if alive_count == 3
    end
  end

  def as_json(options = {})
    super(only: [ :x, :y, :alive ])
  end
end
