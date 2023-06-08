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

    # Method to calculate the average coordinates and store the result to 6dp
    def calculate_average(array)
        sum = array.sum(0.0) { |coord| BigDecimal(coord) }
        average = sum / array.count
        formatted_average = average.round(6).to_s
    end


    def create
        @meeting = @user.meetings.build(meeting_params)

        if @meeting.save
            @lats = []
            @lngs = []
            @places = []
            # Iterate over each location for the new meeting
            meeting_params[:locations_attributes].each do |_, location_params|
                address = location_params[:address]
                location = @meeting.locations.find_by(address: address)

                location.type = "user inputted"

                # Get the place ID of the location from Google maps
                place_id = Google::Maps.places(location.address).first.place_id
                location.google_maps_place_id = place_id

                location.save
                
                # Add the place details to the places array
                place =  Google::Maps.place(place_id)
                @places << place

                # Find the lat and long coordinates and add them to the coordinate arrays
                @lats << place.latitude
                @lngs << place.longitude
            end
                
            # Find the halfway coordinates between all the locations
            halfway_coordinates = "#{calculate_average(@lats)},#{calculate_average(@lngs)}"

            # Get the place ID of the halfway point from Google maps
            results = httpartytime("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{halfway_coordinates}&key=#{ENV['GOOGLE_MAPS_API_KEY']}")
            halfway_id = results[:place_id]

            # Create the halfway point as a location in the new meeting ID
            halfway_point = @meeting.locations.create(google_maps_place_id: halfway_id, distance_from_halfway: 0, time_from_halfway: 0, type: 'halfway', address: halfway_coordinates)

            # # Find the route between each location and the halfway point
            # @routes = []
            # meeting_params[:locations_attributes].each do |_, location_params|
            #     address = location_params[:address]
            #     location = @meeting.locations.find_by(address: address)

            #     # Save the distance and duration between each location and the halfway point
            #     route = Google::Maps.route(location.google_maps_place_id, halfway_point.google_maps_place_id)
            #     @routes << route

            #     puts "................................"
            #     puts route
            #     puts "................................"

            #     location.distance_from_halfway = route.distance.value
            #     location.time_from_halfway = route.duration.value
            # end

            redirect_to results_path(@user, @meeting, @places, @lats, @lngs)
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
            params.require(:meeting).permit(:name, :place_type, :transport_type, locations_attributes: [:id, :address])
        end
end
