class PlacementsController < ApplicationController
    before_action :authorized?
    require 'csv'


    def index
        @placements = Placement.all
        @one_time = ReuseWorkers.call(@placements)[1]
        @repeated = ReuseWorkers.call(@placements)[0]
    end

    def retrieve
        url = "https://marketplace-app-sj.herokuapp.com/api/v1/reports?api_user=Reporting_app&token=#{ENV["KEY"]}"
        response = RestClient.get(url)
        @placements = JSON.parse(response)
        @placements.each do |placement|
            puts placement
            puts placement['worker_id']
            last_report = Placement.last
            if !last_report.nil? 
                if last_report.placement_id < placement['id']
                start_date=placement['start_date'].to_date
                end_date=placement['end_date'].to_date
                salary=placement['monthly_salary']
                placement_id=placement['id']
                client =placement['client']['name']
                sector =placement['job_request']['category']
                placement_id=placement['id']
                worker_id = placement['worker_id']
                months = array_of_months(start_date, end_date)
                days = array_of_months(start_date, end_date)
                Placement.create(worker_id: worker_id, end_date: end_date, start_date: start_date, monthly_salary: salary, client: client, category: sector, placement_id: placement_id)
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
              worker_id = placement['worker_id']
              months = array_of_months(start_date, end_date)
              days = array_of_days(start_date, end_date)
              Placement.create(worker_id: worker_id, end_date: end_date, start_date: start_date, monthly_salary: salary, client: client, category: sector, placement_id: placement_id)
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

    private

    def array_of_months(start_date,end_date)
      from = start_date
      to = end_date
      (from..to).group_by {|a| [a.year, a.month]}.map do |group|
        group.first.last
      end
    end
 
    def array_of_days(start_date, end_date)
      from = start_date
      to = end_date
      (from..to).group_by {|a| [a.year, a.month]}.map do |group|
        group.last.length
      end
    end

    def authorized?
        return unless !current_admin
        flash[:danger]="Access denied"
        redirect_to root_path
    end
end

