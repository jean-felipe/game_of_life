class Api::GridsController < ActionController::API
  before_action :load_grid, except: :create

  def create
    grid = GridCreationService.new(grid_params).create_grid
    render json: { id: grid.id }, status: :created
  end

  def next_state
    GridUpdateService.new(@grid).update_grid
    render json: @grid.to_json(include: :cells)
  end

  def n_states_away
    GridUpdateService.new(@grid).update_n_states_away(params[:number].to_i)
    render json: @grid.to_json(include: :cells)
  end

  def final_state
    begin
      grid = GridFinalStateService.new(@grid).calculate_final_state
      render json: grid.to_json(include: :cells)
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private

  def grid_params
    params.require(:grid).permit(:name, :size_x, :size_y, cells: [:x, :y, :alive])
  end

  def load_grid
    @grid = Grid.find(params[:id])
  end
end
