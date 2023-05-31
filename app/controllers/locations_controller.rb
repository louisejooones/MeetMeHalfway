class LocationsController < ApplicationController
    
    before_action :set_meeting, only: [:show, :edit, :update, :destroy]

    def new
        @location = @meeting.locations.new
    end

    def create
        @meeting.locations.create(location_params)
        redirect_to @meeting
    end

    private

        def set_meeting
            @meeting = Meeting.find(params[:meeting_id])
        end

        def location_params
            params.require(:location).permit(:type, :name, :address, :latitude, :longitude, :distance_from_halfway, :time_from_halfway)
        end

end
