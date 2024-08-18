# app/services/grid_final_state_service.rb
class GridFinalStateService
  def initialize(grid, max_iterations = 100)
    @grid = grid
    @max_iterations = max_iterations
  end

  def calculate_final_state
    previous_states = []

    @max_iterations.times do
      state_snapshot = @grid.cells.map { |cell| [cell.x, cell.y, cell.alive] }

      if previous_states.include?(state_snapshot)
        return @grid
      end

      previous_states << state_snapshot
      GridUpdateService.new(@grid).update_grid
    end

    raise "Board did not reach a stable state within the maximum number of iterations."
  end
end
