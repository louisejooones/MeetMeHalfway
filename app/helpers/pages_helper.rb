module PagesHelper

    def member_time
        # Calculate the duration in seconds since the user became a member
        duration_in_seconds = Time.now - current_user.created_at

        # Convert the duration to the appropriate units (days, months, years)
        if duration_in_seconds < 1.minute
            duration = "less than a minute"
        elsif duration_in_seconds < 1.hour
            duration = "#{(duration_in_seconds / 1.minute).to_i} minutes"
        elsif duration_in_seconds < 1.day
            duration = "#{(duration_in_seconds / 1.hour).to_i} hours"
        elsif duration_in_seconds < 1.month
            duration = "#{(duration_in_seconds / 1.day).to_i} days"
        elsif duration_in_seconds < 1.year
            duration = "#{(duration_in_seconds / 1.month).to_i} months"
        else
            duration = "#{(duration_in_seconds / 1.year).to_i} years"
        end
    end

end