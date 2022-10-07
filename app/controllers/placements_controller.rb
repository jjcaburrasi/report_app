class PlacementsController < ApplicationController

    def index
        @placements = Placement.all
    end

    def retrieve
        url = "http://localhost:3000/api/v1/reports?api_user=Reporting_app&token=H2SO4plusNaOHequalNaSO4plusH2O"
        response = RestClient.get(url)
        last_report = Report.last
        @placements = JSON.parse(response)
        @placements.each do |placement|
            if !last_report.nil? 
                if last_report.placement_id < placement['id']
                start_date=placement['start_date'].to_date
                end_date=placement['end_date'].to_date
                salary=placement['monthly_salary']
                placement_id=placement['id']
                client =placement['client']['name']
                sector =placement['job_request']['category']
                placement_id=placement['id']
                months = array_of_months(start_date, end_date)
                days = array_of_months(start_date, end_date)
                Placement.create(end_date: end_date, start_date: start_date, monthly_salary: salary, client: client, category: sector)
                else 
                flash[:info] = "There aren't new placements" 
                # redirect_to request.referer
                end
          else
              start_date=placement['start_date'].to_date
              end_date=placement['end_date'].to_date
              salary=placement['monthly_salary']
              placement_id=placement['id']
              client =placement['client']['name']
              sector =placement['job_request']['category']
              placement_id=placement['id']
              months = array_of_months(start_date, end_date)
              days = array_of_days(start_date, end_date)
              Placement.create(end_date: end_date, start_date: start_date, monthly_salary: salary, client: client, category: sector)
          end
        end
      redirect_to placements_path
    end

    def export_placements
          @placements=Placement.all
          respond_to do |format|
          format.html
          format.csv { send_data @placements.to_csv, filename: "placements-#{Date.today}.csv" }
          end
    end
end