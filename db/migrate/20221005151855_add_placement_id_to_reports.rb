class AddPlacementIdToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :placement_id, :integer
  end
end
