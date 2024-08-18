class GridsController < ApplicationController
  def index
    @grid = Grid.find_or_create_by(name: "Default")
    @cells = @grid.cells
  end

  def update
    @grid = Grid.find(params[:id])
    @grid.cells.each(&:update_state)
    @grid.cells.each(&:save)

    redirect_to grids_path
  end
end
