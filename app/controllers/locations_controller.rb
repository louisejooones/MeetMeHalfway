class LocationsController < ApplicationController
    
    before_action :set_meeting, only: [:new, :create]
    before_action :set_location, only: [:show, :edit, :update, :destroy]

    def index
        @locations = @meeting.locations
    end

    def show
    end
    
    def new
        @location = @meeting.locations.new
    end

    def create
        @meeting.locations.create(location_params)
        redirect_to @meeting
    end

    def edit
    end

    def destroy
        @location.destroy
        redirect_to user_meetings_locations_path
    end

    private

        def set_meeting
            @meeting = Meeting.find(params[:meeting_id])
        end

        def set_location
            @location = Location.find(params[:location_id])
        end

        def location_params
            params.require(:location).permit(:type, :name, :address, :latitude, :longitude, :distance_from_halfway, :time_from_halfway)
        end

end
