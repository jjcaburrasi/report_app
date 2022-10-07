class PlacementsController < ApplicationController
    before_action :authorized?

    def index
        @placements = Placement.all
    end
end

private
    def authorized?
        return unless !current_admin
        flash[:danger]="Access denied"
        redirect_to root_path
    end