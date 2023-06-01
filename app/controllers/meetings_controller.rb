class MeetingsController < ApplicationController

    before_action :set_meeting, only: [:show, :edit, :update, :destroy]

    def index
        @meetings = current_user.meetings
    end

    def show
        @locations = @meeting.locations
    end

    def new
        @meeting = current_user.meetings.new
    end

    def create
        @meeting = current_user.meetings.new(meeting_params)
        puts current_user
        puts meeting_params
        if @meeting.save
            redirect_to user_meetings_path(current_user, @meeting)
        else
            render :new
        end
    end

    def edit
    end

    def update        
        @meeting.update(meeting_params)
        redirect_to user_meeting_path(current_user, @meeting)
    end

    def destroy
        @meeting.destroy
        redirect_to user_meetings_path(current_user)
    end

    private

        def set_meeting
            @meeting = Meeting.find(params[:id]) 
        end

        def meeting_params
            params.require(:meeting).permit(:name, :place_type, :transport_type, :total_distance, :total_time)
        end
end
