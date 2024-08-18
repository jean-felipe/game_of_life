# app/services/grid_final_state_service.rb
class GridFinalStateService
  def initialize(grid, max_iterations = 100)
    @grid = grid
    @max_iterations = max_iterations
  end

  def calculate_final_state
    previous_states = {}
    @max_iterations.times do |i|
      state_hash = @grid.cells.map(&:alive).hash

      return @grid if previous_states[state_hash]

      previous_states[state_hash] = i
      GridUpdateService.new(@grid).update_grid
    end

    raise "Board did not reach a stable state within the maximum number of iterations."
  end
end
