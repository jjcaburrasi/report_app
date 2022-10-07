class AddWorkerIdToPlacements < ActiveRecord::Migration[6.1]
  def change
    add_column :placements, :worker_id, :integer
  end
end
