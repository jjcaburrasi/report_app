class RemoveEndDateAndStartDateFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :end_date, :date
    remove_column :reports, :start_date, :date
  end
end
