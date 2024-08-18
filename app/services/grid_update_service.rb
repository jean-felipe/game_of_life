# app/services/grid_update_service.rb
class GridUpdateService
  def initialize(grid)
    @grid = grid
  end

  def update_grid
    @grid.cells.each(&:update_state)
    @grid.cells.each(&:save)
  end

  def update_n_states_away(n)
    n.times { update_grid }
    @grid
  end
end
