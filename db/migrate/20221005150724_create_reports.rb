class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.float :monthly_salary, null: false
      t.string :client, null: false
      t.string :sector, null: false

      t.timestamps
    end
  end
end
