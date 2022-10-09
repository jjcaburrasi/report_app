class RemoveUniquenessConstraint < ActiveRecord::Migration[6.1]
  def change
    remove_index :reports, column: :placement_id, unique: true
    add_index :reports, :placement_id
  end
end
