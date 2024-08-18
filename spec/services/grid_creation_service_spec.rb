require 'rails_helper'

RSpec.describe GridCreationService, type: :service do
  describe '#create_grid' do
    it 'creates a grid and its initial cells' do
      service = GridCreationService.new(name: 'Test Grid', size_x: 10, size_y: 10)
      grid = service.create_grid

      expect(grid).to be_persisted
      expect(grid.cells.count).to eq(100) # 10x10 grid
    end
  end
end
