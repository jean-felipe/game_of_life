# app/services/grid_creation_service.rb
class GridCreationService
  def initialize(grid_params)
    @grid_params = grid_params
  end

  def create_grid
    grid = Grid.create!(@grid_params.except(:cells))
    create_initial_cells(grid)
    grid
  end

  private

  def create_initial_cells(grid)
    (0..9).each do |x|
      (0..9).each do |y|
        Cell.create!(grid: grid, x: x, y: y, alive: [true, false].sample)
      end
    end
  end
end
