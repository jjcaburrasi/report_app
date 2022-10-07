class CreatePlacements < ActiveRecord::Migration[6.1]
  def change
    create_table :placements do |t|
      t.string :client
      t.integer :monthly_salary
      t.date    :start_date
      t.date    :end_date
      t.string :category

      t.timestamps
    end
  end
end
