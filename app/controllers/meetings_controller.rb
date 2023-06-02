class MeetingsController < ApplicationController

    include UserCommon
    include MeetingCommon

    def index
        @meetings = current_user.meetings
    end

    def show
        @locations = @meeting.locations
    end

    def new
    end

    def create
        @meeting = @user.meetings.new(meeting_params)
        if @meeting.save
            redirect_to results_path(user_id: @user.id, id: @meeting.id)
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

        def meeting_params
            params.require(:meeting).permit(:name, :place_type, :transport_type, :total_distance, :total_time)
        end
end
