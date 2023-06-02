class PagesController < ApplicationController

  include UserCommon
  include MeetingCommon
  
  before_action :authenticate_user!, only: [:dashboard]

  def search
  end

  def results
    puts "user for results is #{@user}"
    puts "meeting for results is #{@meeting}"
  end

  def dashboard
  end

end
