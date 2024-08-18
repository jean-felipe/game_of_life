# app/services/grid_update_service.rb
class GridUpdateService
  def initialize(grid)
    @grid = grid
  end

  def update_grid
    @grid.cells.in_batches(of: 1000) do |batch|
      batch.each(&:update_state)
      batch.each(&:save)
    end
  end

  def update_n_states_away(n)
    n.times { update_grid }
    @grid
  end
end
