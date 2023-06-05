module MeetingCommon
    extend ActiveSupport::Concern
  
    included do
        before_action :set_meetings, only: [:dashboard]
        before_action :build_meeting, only: [:search, :new, :create]
        before_action :set_meeting, only: [:results, :show, :edit, :update, :destroy]
    end
  
    private

    def build_meeting
        # Build a new meeting
        @meeting = @user.meetings.build
        # Build two new locations for the form
        2.times do
            @meeting.locations.build
        end
    end
  
    def set_meetings
        @meetings = current_user.meetings
    end

    def set_meeting
        puts params
        @meeting = Meeting.find(params[:id]) 
    end

  end
  