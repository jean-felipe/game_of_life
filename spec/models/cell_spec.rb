# == Schema Information
#
# Table name: cells
#
#  id         :integer          not null, primary key
#  alive      :boolean
#  x          :integer
#  y          :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  grid_id    :integer          not null
#
# Indexes
#
#  index_cells_on_grid_id              (grid_id)
#  index_cells_on_grid_id_and_x_and_y  (grid_id,x,y)
#
# Foreign Keys
#
#  grid_id  (grid_id => grids.id)
#
require 'rails_helper'

RSpec.describe Cell, type: :model do
  let!(:grid) { Grid.create!(name: 'Test Grid', size_x: 5, size_y: 5) }

  describe '#neighbors' do
    before do
      # Create cells around the central cell (2,2)
      [
        [1, 1], [1, 2], [1, 3],
        [2, 1],        [2, 3],
        [3, 1], [3, 2], [3, 3]
      ].each do |x, y|
        Cell.create!(grid: grid, x: x, y: y, alive: true)
      end
    end

    it 'returns the correct number of neighbors' do
      central_cell = Cell.create!(grid: grid, x: 2, y: 2, alive: true)
      expect(central_cell.neighbors.count).to eq(8)
    end
  end

  describe '#alive_neighbors' do
    before do
      # Create live and dead cells around the central cell (2,2)
      [
        [1, 1], [1, 2], [1, 3],
        [2, 1],        [2, 3],
        [3, 1], [3, 2], [3, 3]
      ].each_with_index do |(x, y), index|
        Cell.create!(grid: grid, x: x, y: y, alive: index.even?)
      end
    end

    it 'returns the correct number of alive neighbors' do
      central_cell = Cell.create!(grid: grid, x: 2, y: 2, alive: true)
      expect(central_cell.alive_neighbors).to eq(4) # 4 alive neighbors out of 8
    end
  end

  describe '#update_state' do
    let!(:central_cell) { Cell.create!(grid: grid, x: 2, y: 2, alive: initial_state) }

    context 'when a live cell has fewer than 2 live neighbors' do
      before do
        Cell.create!(grid: grid, x: 1, y: 1, alive: true)
      end

      let(:initial_state) { true }

      it 'dies due to underpopulation' do
        central_cell.update_state
        expect(central_cell.alive).to be_falsey
      end
    end

    context 'when a live cell has 2 or 3 live neighbors' do
      before do
        Cell.create!(grid: grid, x: 1, y: 1, alive: true)
        Cell.create!(grid: grid, x: 1, y: 2, alive: true)
      end

      let(:initial_state) { true }

      it 'stays alive' do
        central_cell.update_state
        expect(central_cell.alive).to be_truthy
      end
    end

    context 'when a live cell has more than 3 live neighbors' do
      before do
        [
          [1, 1], [1, 2], [1, 3],
          [2, 1]
        ].each do |x, y|
          Cell.create!(grid: grid, x: x, y: y, alive: true)
        end
      end

      let(:initial_state) { true }

      it 'dies due to overpopulation' do
        central_cell.update_state
        expect(central_cell.alive).to be_falsey
      end
    end

    context 'when a dead cell has exactly 3 live neighbors' do
      before do
        [
          [1, 1], [1, 2], [1, 3]
        ].each do |x, y|
          Cell.create!(grid: grid, x: x, y: y, alive: true)
        end
      end

      let(:initial_state) { false }

      it 'comes to life by reproduction' do
        central_cell.update_state
        expect(central_cell.alive).to be_truthy
      end
    end
  end

  describe '#as_json' do
    let!(:cell) { Cell.create!(grid: grid, x: 2, y: 2, alive: true) }

    it 'returns a hash with the correct attributes' do
      json_data = cell.as_json
      expect(json_data).to eq({ "x" => 2, "y" => 2, "alive" => true })
    end
  end
end
