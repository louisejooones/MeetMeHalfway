module MeetingsHelper

    def generate_parameters(meeting)
        
        # Get the place ids for the user locations and the halfway point
        place_ids = []
        halfway_place_id = nil
        halfway_coordinates = {}

        meeting.locations.each do |location|
            if location.type == "halfway"
                halfway_place_id = location.google_maps_place_id
                halfway_coordinates = location.address
            else
                place_ids << location.google_maps_place_id
            end
        end


        # Populate the list of waypoints to include the halfway point between each user location
        waypoints = []
        if place_ids.count > 2
            place_ids[1..-2].each do |place_id|
                waypoints << "place_id:#{place_id}"
                waypoints << "place_id:#{halfway_place_id}"
            end
        else
            waypoints << "place_id:#{halfway_place_id}"
        end

        # Build the directions parameters string
        parameters = "key=#{ENV['GOOGLE_MAPS_API_KEY']}&origin=place_id:#{place_ids.first}&destination=place_id:#{place_ids.last}&waypoints=#{waypoints.join('|')}&center=#{halfway_coordinates}"

    end

end
