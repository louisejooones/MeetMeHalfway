module UserCommon
    extend ActiveSupport::Concern
  
    included do
        before_action :set_user, only: [:search, :results, :new, :create]
    end
  
    private
  
    def set_user
        if user_signed_in?
            @user = current_user
        else
            @user = User.find_by(default_user: true)
        end
    end

end
