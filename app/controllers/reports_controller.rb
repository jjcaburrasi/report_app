class ReportsController < ApplicationController
  def index
      url = "http://localhost:3000/api/v1/reports?api_user=Reporting_app&token=H2SO4plusNaOHequalNaSO4plusH2O"
      response = RestClient.get(url)
      @placements = JSON.parse(response)
      @placements.each do |placement|
            start_date=placement['start_date']
            end_date=placement['end_date']
            salary=placement['monthly_salary']
            placement_id=placement['id']
            client=placement['client']['name']
            sector=placement['job_request']['category']
            # placement_id=placement['id']
            Report.create!(start_date: start_date, end_date: end_date, monthly_salary: salary, client: client, sector: sector)
          end
      @reports=Report.all
  end
end
