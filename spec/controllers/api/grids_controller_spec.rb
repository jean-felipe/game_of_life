require 'rails_helper'

RSpec.describe Api::GridsController, type: :controller do
  describe 'POST /api/v1/grids' do
    it 'creates a new grid and returns its ID' do
      expect_any_instance_of(GridCreationService).to receive(:create_grid).and_call_original

      post :create, params: {
        grid: {
          name: 'Test Grid',
          size_x: 10,
          size_y: 10,
          cells: [
            { x: 0, y: 0, alive: true },
            { x: 0, y: 1, alive: false }
          ]
        }
      }

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key('id')
    end
  end

  describe 'GET /api/v1/grids/:id/next_state' do
    let!(:grid) { Grid.create!(name: 'Test Grid', size_x: 10, size_y: 10) }

    before do
      (0..9).each do |x|
        (0..9).each do |y|
          Cell.create(grid: grid, x: x, y: y, alive: [true, false].sample)
        end
      end
    end

    it 'returns the next state of the grid' do
      expect_any_instance_of(GridUpdateService).to receive(:update_grid).and_call_original

      get :next_state, params: { id: grid.id }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['cells']).to all(include('x', 'y', 'alive'))
    end
  end

  describe 'GET /api/v1/grids/:id/n_states_away/:n' do
    let!(:grid) { Grid.create!(name: 'Test Grid', size_x: 10, size_y: 10) }

    before do
      (0..9).each do |x|
        (0..9).each do |y|
          Cell.create(grid: grid, x: x, y: y, alive: [true, false].sample)
        end
      end
    end

    it 'returns the state of the grid after n steps' do
      expect_any_instance_of(GridUpdateService).to receive(:update_n_states_away).with(5).and_call_original

      get :n_states_away, params: { id: grid.id, number: 5 }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['cells']).to all(include('x', 'y', 'alive'))
    end
  end

  describe 'GET /api/v1/grids/:id/final_state' do
    let!(:grid) { Grid.create!(name: 'Test Grid', size_x: 10, size_y: 10) }

    before do
      (0..9).each do |x|
        (0..9).each do |y|
          Cell.create(grid: grid, x: x, y: y, alive: [true, false].sample)
        end
      end
    end

    it 'returns the final stable state of the grid or an error if it doesn’t stabilize' do
      expect_any_instance_of(GridFinalStateService).to receive(:calculate_final_state).and_call_original

      get :final_state, params: { id: grid.id }

      if response.status == 200
        json_response = JSON.parse(response.body)
        expect(json_response['cells']).to all(include('x', 'y', 'alive'))
      else
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end
    end
  end
end
