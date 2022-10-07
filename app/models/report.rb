class Report < ApplicationRecord
    has_many :comments
    def self.to_csv
        attributes = %w{month days salary_earned client sector}
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |report|
            csv << attributes.map{ |attr| report.send(attr) }
          end
        end
      end
end
