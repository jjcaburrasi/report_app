class AddSalaryEarnedToReportsRemoveMonthlySalary < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :monthly_salary, :float
    add_column :reports, :salary_earned, :float
  end
end
