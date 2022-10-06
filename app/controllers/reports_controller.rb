class ReportsController < ApplicationController
  require 'csv'
  def index
      url = "http://localhost:3000/api/v1/reports?api_user=Reporting_app&token=H2SO4plusNaOHequalNaSO4plusH2O"
      response = RestClient.get(url)
      last_report = Report.last
      @placements = JSON.parse(response)
      @placements.each do |placement|
        if !last_report.nil? 
          if last_report.placement_id < placement['id']
            start_date=placement['start_date']
            end_date=placement['end_date']
            salary=placement['monthly_salary']
            placement_id=placement['id']
            # client=placement['client']['name']
            client =placement['client']['name']
            # sector=placement['job_request']['category']
            sector =placement['job_request']['category']
            placement_id=placement['id']
            Report.create!(start_date: start_date, end_date: end_date, monthly_salary: salary, client: client, sector: sector, placement_id: placement_id)
          else 
            flash[:info] = "There isn't new reports" 
            # redirect_to request.referer
          end
        else
            start_date=placement['start_date']
            end_date=placement['end_date']
            salary=placement['monthly_salary']
            placement_id=placement['id']
            # client=placement['client']['name']
            client =placement['client']['name']
            # sector=placement['job_request']['category']
            sector =placement['job_request']['category']
            placement_id=placement['id']
            Report.create!(start_date: start_date, end_date: end_date, monthly_salary: salary, client: client, sector: sector, placement_id: placement_id)
        end
      end
      @reports=Report.all
      respond_to do |format|
        format.html
        format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
      end
  end

#   def export
#     @reports = Report.all
#     respond_to do |format|
#         format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
#       end
#     end
#   end
end
