module PagesHelper

    def member_time
        # Calculate the duration in seconds since the user became a member
        duration_in_seconds = Time.now - current_user.created_at

        # Convert the duration to the appropriate units (days, months, years)
        string = seconds_to_time(duration_in_seconds)
        result = string.match(/(.*?) and/)
        if result
            extracted_characters = result[1]
        else
            extracted_characters=string
        end
    end

end