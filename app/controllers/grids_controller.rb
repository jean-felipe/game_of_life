class GridsController < ApplicationController
  def index
    @grid = Grid.last
    @cells = @grid.cells
  end

  def create
    GridCreationService.new({name: 'New grid', size_x: 10, size_y: 10}).create_grid

    redirect_to grids_path
  end

  def update
    @grid = Grid.find(params[:id])
    @grid.cells.each(&:update_state)
    @grid.cells.each(&:save)
    redirect_to grids_path  end
end
