module MeetingCommon
    extend ActiveSupport::Concern
  
    included do
        before_action :set_meetings, only: [:dashboard]
        before_action :build_meeting, only: [:search, :new, :create]
        before_action :set_meeting, only: [:results, :show, :edit, :update, :destroy]
    end
  
    private

    def build_meeting
        puts "Building"
        puts "user: #{@user}"
        @meeting = @user.meetings.build
    end
  
    def set_meetings
        @meetings = current_user.meetings
    end

    def set_meeting
        puts params
        @meeting = Meeting.find(params[:id]) 
    end

  end
  