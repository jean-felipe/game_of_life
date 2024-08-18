require 'rails_helper'

RSpec.describe Grid, type: :model do
  let!(:grid) { Grid.create!(name: 'Test Grid', size_x: 5, size_y: 5) }

  describe '#cell_at' do
    before do
      # Create cells at specific coordinates
      Cell.create!(grid: grid, x: 2, y: 3, alive: true)
      Cell.create!(grid: grid, x: 4, y: 4, alive: false)
    end

    it 'returns the correct cell at given coordinates' do
      cell = grid.cell_at(2, 3)
      expect(cell).not_to be_nil
      expect(cell.x).to eq(2)
      expect(cell.y).to eq(3)
      expect(cell.alive).to be_truthy
    end

    it 'returns nil if there is no cell at given coordinates' do
      cell = grid.cell_at(1, 1)
      expect(cell).to be_nil
    end
  end

  describe '#as_json' do
    before do
      # Create some cells
      [
        [ 1, 1, true ],
        [ 2, 2, false ],
        [ 3, 3, true ]
      ].each do |x, y, alive|
        Cell.create!(grid: grid, x: x, y: y, alive: alive)
      end
    end

    it 'returns a hash with the correct attributes and included cells' do
      json_data = grid.as_json
      expect(json_data['name']).to eq('Test Grid')
      expect(json_data['size_x']).to eq(5)
      expect(json_data['size_y']).to eq(5)
      expect(json_data['cells']).to be_an(Array)
      expect(json_data['cells'].size).to eq(3)

      cell_data = json_data['cells'].find { |c| c['x'] == 1 && c['y'] == 1 }
      expect(cell_data).not_to be_nil
      expect(cell_data['alive']).to be_truthy
    end
  end
end
