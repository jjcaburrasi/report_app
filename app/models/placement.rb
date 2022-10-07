class Placement < ApplicationRecord
    def self.to_csv
        attributes = %w{client monthly_salary start_date end_date category}
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |placement|
            csv << attributes.map{ |attr| placement.send(attr) }
          end
        end
    end
end