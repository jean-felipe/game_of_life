# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_18_034946) do
  create_table "cells", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.boolean "alive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grid_id", null: false
    t.index ["grid_id"], name: "index_cells_on_grid_id"
  end

  create_table "grids", force: :cascade do |t|
    t.string "name"
    t.integer "size_x"
    t.integer "size_y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cells", "grids"
end
