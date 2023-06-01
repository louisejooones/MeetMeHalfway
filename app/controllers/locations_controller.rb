class LocationsController < ApplicationController
    
    before_action :set_meeting, only: [:index, :new, :create, :edit, :update, :destroy]
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
        redirect_to user_meeting_path(current_user, @meeting)
    end

    def edit
    end

    def update        
        @location.update(location_params)
        redirect_to user_meeting_location_path(current_user, @meeting, @location)
    end

    def destroy
        @location.destroy
        redirect_to user_meeting_path(current_user, @meeting)
    end

    private

        def set_meeting
            @meeting = Meeting.find(params[:meeting_id])
        end

        def set_location
            @location = Location.find(params[:id])
        end

        def location_params
            params.require(:location).permit(:type, :name, :address, :latitude, :longitude, :distance_from_halfway, :time_from_halfway)
        end

end
