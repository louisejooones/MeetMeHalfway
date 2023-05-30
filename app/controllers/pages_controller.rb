class PagesController < ApplicationController
  
  before_action :authenticate_user!, only: [:dashboard]
  
  def search
  end

  def dashboard
  end
end
