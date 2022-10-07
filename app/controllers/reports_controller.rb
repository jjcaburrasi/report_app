class ReportsController < ApplicationController
  require 'csv'
  def sync
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
            (0..(months.length-1)).each do |i|
              salary_earned = ((salary.to_f)/30)*days[i]
              Report.create!(days: days[i], month: months[i], salary_earned: salary_earned, client: client, sector: sector, placement_id: placement_id)
            end
          else 
            flash[:info] = "There aren't new reports" 
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
            days = array_of_months(start_date, end_date)
            Placement.create(end_date: end_date, start_date: start_date, monthly_salary: salary, client: client, category: sector)
            (0..(months.length-1)).each do |i|
              salary_earned = ((salary.to_f)/30)*days[i]
              Report.create!(days: days[i], month: months[i], salary_earned: salary_earned, client: client, sector: sector, placement_id: placement_id)
            end
        end
      end
    redirect_to reports_path
  end
 def index
    @placements
    if params[:commit].nil?
      @reports=Report.all
      respond_to do |format|
      format.html
      format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
      end
    else
      if params[:category] && params[:client].nil?
      @reports=Report.where("sector= ?", params[:category])
      elsif params[:client] && params[:category].nil?
      @reports=Report.where("client= ?", params[:client])
      end
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
      
end
