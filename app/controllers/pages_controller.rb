class PagesController < ApplicationController

  include UserCommon
  include MeetingCommon
  
  before_action :authenticate_user!, only: [:dashboard]

  def search
  end

  def results
    
  end

  def dashboard
  end

end
