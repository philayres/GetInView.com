class PublicController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_ads
  
  before_action :set_social_meta
  
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  
  def new
    redirect_to "/"
  end

  
  def edit
    redirect_to "/"
  end

 
  def create
    redirect_to "/"
  end

  
  def update
    redirect_to "/"
  end

  
  def destroy
    redirect_to "/"
  end
  private
  
  def not_found
    render 'layouts/not_found', layout: 'public', status: 404
  end
  
  def set_ads
    @ad_slot = :bottom
  end
  
  def set_social_meta
    @title = "Find hotels, guesthouses, B&Bs and hostels worldwide"
    @description = "No booking fees for you. Find accommodation in out of the way places. Support independent businesses by saving them commissions."
    @image = "https://s3.amazonaws.com/getinviewwww/social/GetInViewBackground.jpg"
  end
end
