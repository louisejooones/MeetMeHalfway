module UserCommon
    extend ActiveSupport::Concern
  
    included do
        before_action :set_user, only: [:search, :results, :new, :create]
    end
  
    private
  
    def set_user
        if user_signed_in?
            puts "There's a user: #{current_user.id}"
            @user = current_user
        else
            puts "No user found: #{User.find_by(default_user: true).id}"
            @user = User.find_by(default_user: true)
        end
        puts "user: #{@user}"
    end

end
