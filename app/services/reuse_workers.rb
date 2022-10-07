class ReuseWorkers < ApplicationService
    def initialize(placements)
        @placements = placements
    end

    def call
        ids = array_of_ids(@placements)
        hash = ids.tally 
        repeated = multiple(hash)
        only_one = only_one(hash)
        return [repeated, only_one]
    end

    private

        def array_of_ids(placements)
            placements.each.map{|placement| placement.worker_id}
        end

        def only_one(hash)
            start = 0
            hash.each do |key,value|
                if value == 1
                    start+=1
                end
            end
            return start
        end

        def multiple(hash)
            start = 0
            hash.each do |key,value|
                if value > 1
                    start+=1
                end
            end
            return start
        end
end