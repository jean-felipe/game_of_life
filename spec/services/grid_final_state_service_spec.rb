require 'rails_helper'

RSpec.describe GridFinalStateService, type: :service do
  let!(:grid) { Grid.create!(name: 'Test Grid', size_x: 10, size_y: 10) }

  before do
    (0..9).each do |x|
      (0..9).each do |y|
        Cell.create(grid: grid, x: x, y: y, alive: [true, false].sample)
      end
    end
  end

  describe '#calculate_final_state' do
    it 'returns the final state of the grid if it stabilizes' do
      service = GridFinalStateService.new(grid, 100)
      expect { service.calculate_final_state }.not_to raise_error
    end

    it 'raises an error if the grid does not stabilize' do
      service = GridFinalStateService.new(grid, 1) # Small number to force failure
      expect { service.calculate_final_state }.to raise_error("Board did not reach a stable state within the maximum number of iterations.")
    end
  end
end
