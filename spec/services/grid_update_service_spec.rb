require 'rails_helper'

RSpec.describe GridUpdateService, type: :service do
  let!(:grid) { Grid.create!(name: 'Test Grid', size_x: 10, size_y: 10) }

  before do
    (0..9).each do |x|
      (0..9).each do |y|
        Cell.create(grid: grid, x: x, y: y, alive: [true, false].sample)
      end
    end
  end

  describe '#update_grid' do
    it 'updates the grid to the next state' do
      service = GridUpdateService.new(grid)
      expect { service.update_grid }.to change { grid.cells.where(alive: true).count }
    end
  end
end
