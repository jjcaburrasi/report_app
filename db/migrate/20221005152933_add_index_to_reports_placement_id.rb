class AddIndexToReportsPlacementId < ActiveRecord::Migration[6.1]
  def change
    add_index :reports, :placement_id, unique: true
  end
end
