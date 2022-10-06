class AddMonthToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :month, :integer, null: false
  end
end
