class AddIndexToPlacementPlacementId < ActiveRecord::Migration[6.1]
  def change
    add_index :placements, :placement_id, unique: true
  end
end
