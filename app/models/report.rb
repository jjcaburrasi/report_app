class Report < ApplicationRecord
    def self.to_csv
        attributes = %w{start_date end_date monthly_salary client sector}
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |report|
            csv << attributes.map{ |attr| report.send(attr) }
          end
        end
      end
end
