class AddDaysToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :days, :integer, null: false
  end
end
