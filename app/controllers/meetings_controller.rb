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
        @meeting = @user.meetings.build(meeting_params)
        if @meeting.save
            # Get the place ID of the first location from Google maps

            # Get the place ID of the second location from Google maps

            # Create the first location in the new meeting ID
            @meeting.locations.create(address: params[:meeting][:first_address], type: "User inputted")
            
            # Create the second location in the new meeting ID
            @meeting.locations.create(address: params[:meeting][:second_address], type: "User inputted")
            redirect_to results_path(@user, @meeting)

            # Find the coordinates of each location

            # Find the halfway coordinates

            # Get the place ID of the halfway point

            # Create the halfway point as a location in the new meeting ID

            # Find the route between the first location and the halfway point

            # Find the route between the halfway point and the second location

            # Send the distance between 


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
            params.require(:meeting).permit(:name, :place_type, :transport_type)
        end
end
