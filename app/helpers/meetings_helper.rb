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
        parameters = "key=#{Rails.application.config.google_maps_api_key}&origin=place_id:#{place_ids.first}&destination=place_id:#{place_ids.last}&waypoints=#{waypoints.join('|')}"

    end

    # Method to calculate the total distance in miles
    def metres_to_miles(metres)
        metres_per_mile = 1609.344
        if metres
            miles = metres.to_f / metres_per_mile
            rounded_miles = miles.round
            "#{rounded_miles} miles"
        else
            "not found"
        end
        
    end

    # Method to calculate the total time from seconds to days/hours/minutes
    def seconds_to_time(seconds)
        minutes_per_hour = 60
        hours_per_day = 24
      
        if seconds
            if seconds < 1.minute
                duration = "#{seconds} seconds"
            elsif seconds < 1.hour
                minutes = (seconds / 1.minute).to_i
                duration = "#{minutes} minute#{minutes > 1 ? 's' : ''}"
            elsif seconds < 1.day
                hours = (seconds / 1.hour).to_i
                minutes = ((seconds % 1.hour) / 1.minute).to_i
                duration = "#{hours} hour#{hours > 1 ? 's' : ''} and #{minutes} minute#{minutes > 1 ? 's' : ''}"
            else
                days = (seconds / 1.day).to_i
                hours = ((seconds % 1.day) / 1.hour).to_i
                minutes = (((seconds % 1.day) % 1.hour) / 1.minute).to_i
                duration = "#{days} day#{days > 1 ? 's' : ''}, #{hours} hour#{hours > 1 ? 's' : ''}, and #{minutes} minute#{minutes > 1 ? 's' : ''}"
            end
        else
            duration = "not found"
        end
      
        duration
    end

end
