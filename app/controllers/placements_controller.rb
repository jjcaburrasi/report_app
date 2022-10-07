class PlacementsController < ApplicationController

    def index
        @placements = Placement.all
    end
end