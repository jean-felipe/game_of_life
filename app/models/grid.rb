# == Schema Information
#
# Table name: grids
#
#  id         :integer          not null, primary key
#  name       :string
#  size_x     :integer
#  size_y     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Grid < ApplicationRecord
  has_many :cells
  accepts_nested_attributes_for :cells

  def cell_at(x, y)
    cells.find_by(x:, y:)
  end

  def as_json(options = {})
    super(options.merge(include: :cells))
  end
end
