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
        # Build two new locations so the form has two fields
        2.times do |i|
            @meeting.locations.build(name: "Location #{i}")
        end
    end
  
    def set_meetings
        @meetings = current_user.meetings
    end

    def set_meeting
        @meeting = Meeting.find(params[:id]) 
    end

    # Method to send HTTParty requests and parse the response
    def httpartytime(url)
        response = HTTParty.get(url, format: :plain)
        parsed_response = JSON.parse(response, symbolize_names: true)
        result = parsed_response[:results].first
    end

  end
  