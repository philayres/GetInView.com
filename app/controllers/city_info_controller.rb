class CityInfoController < PublicController

  include SearchHandler
  
  def index
    return not_found
  end
  
  def show
    @ad_slot=:both
  
    city = params[:city]
    country = params[:country]
    state = params[:state]
    
    return not_found if city.blank? || state.blank? || country.blank?
    setup_search_form
    @city_info = CityInfo.new 
    @city_info.find_by country, state, city
    return not_found unless @city_info
    @city = @city_info.city
    fresh_when @city_info.updated_at
    @title = "Where to stay in #{@city_info.city_name}, #{ @city_info.state_name }, #{ @city_info.country.full_name}"
    #render "show"
  end
  
end
