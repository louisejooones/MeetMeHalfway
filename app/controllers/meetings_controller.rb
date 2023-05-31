class MeetingsController < ApplicationController

    before_action :set_meeting, only: [:show, :edit, :update, :destroy]

    def index
        @meetings = Meeting.all
    end

    def show
        @locations = @meetings.locations
    end

    def new
        @meeting = Meeting.new
    end

    def create
        Meeting.create(meeting_params)
        redirect_to meetings_path
    end

    def edit
    end

    def update        
        @meeting.update(meeting_params)
        redirect_to @meeting
    end

    def destroy
        @meeting.destroy
        redirect_to meetings_path
    end

    private

        def set_meeting
            @meeting = Meeting.find(params[:id]) 
        end

        def meeting_params
            params.require(:meeting).permit(:name, :place_type, :transport_type, :total_distance, :total_time)
        end
end
