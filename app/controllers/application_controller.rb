class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :set_me
  
  rescue_from ActiveRecord::ValueTooLong, with: :rescue_value_too_long


  
  
  include HelperHandler
  
  class << self
    attr_accessor :permitted_param_list, :index_after_list
    
  end
protected
  
  def set_me
    return unless current_user
    current_user.set_is_me(current_user)
  end
  
  def self.permitted_params *p
    self.permitted_param_list = p
  end
  
  def list_permitted_params
    self.class.permitted_param_list
  end
  
  def self.index_after *actions
    self.index_after_list = actions
  end
  
  def index_after? action
    return unless action && self.class.index_after_list
    self.class.index_after_list.include? action
  end
  
  
  def rescue_value_too_long
    current_object.errors.add :an_entered_value, "was too long to be stored"
    if current_object.id
      render :edit
    else
      render :new
    end
    
  end
end
