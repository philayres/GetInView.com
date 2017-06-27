module SearchHandler

  extend ActiveSupport::Concern
  
  private

  def setup_search_form
    @property = Property.new
    current_object = @property
    @search_action_text = "Find a place to stay"
    @current_location_text = "search your current location"
  end
end