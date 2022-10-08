class ReportsController < ApplicationController
  before_action :authorized?
  require 'csv'
  def sync
      url = "http://localhost:3000/api/v1/reports?api_user=Reporting_app&token=#{ENV["KEY"]}"
      p url
      response = RestClient.get(url)
      @placements = JSON.parse(response)
      @placements.each do |placement|
        last_report = Report.last
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
              days = array_of_days(start_date, end_date)
              (0..(months.length-1)).each do |i|
                salary_earned = ((salary.to_f)/30)*days[i]
                if Report.where(client: client).find_by(month:months[i])
                  @report = Report.where(client: client).find_by(month:months[i])
                  puts @report.id
                  new_salary = @report.salary_earned + salary_earned
                  new_days = @report.days + days[i]
                  @report.update(salary_earned: new_salary, days: new_days)
                else
                  Report.create!(days: days[i], month: months[i], salary_earned: salary_earned, client: client, sector: sector, placement_id: placement_id)
                end
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
            days = array_of_days(start_date, end_date)
            (0..(months.length-1)).each do |i|
              salary_earned = ((salary.to_f)/30)*days[i]
              Report.create!(days: days[i], month: months[i], salary_earned: salary_earned, client: client, sector: sector, placement_id: placement_id)
            end
        end
      end
    redirect_to reports_path
  end

def show
  @report=Report.find(params[:id])
    @comments = @report.comments
end

def export
  if params[:commit].nil?
    @reports=Report.all
    respond_to do |format|
    format.html
    format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
    end
  else
      if !params[:client].nil?
        @reports=Report.where("client= ?", params[:client])
        respond_to do |format|
          format.html
          format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
          end 
      elsif !params[:month].nil?
        @reports=Report.where("month= ?", params[:month])
        respond_to do |format|
          format.html
          format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
          end
      elsif !params[:category].nil?
        @reports=Report.where("sector= ?", params[:category])
        respond_to do |format|
          format.html
          format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
          end   
      end
  end
  
end


 def index
    if !params[:commit].nil?
      if params[:category] 
      @reports=Report.where("sector= ?", params[:category])
      elsif params[:client]
      @reports=Report.where("client= ?", params[:client])
      elsif params[:month]
      @reports=Report.where("month= ?", params[:month])
      end
    else
      @reports=Report.all
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
