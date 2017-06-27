class CitiesController < PublicController
  before_action :set_city, only: [:show]
  include SearchHandler
  
  
  def index
    if params[:country_id].blank? && params[:state_id].blank? && params[:city_name].blank?
      @cities = City.all
    else
      if !params[:country_id].blank?
        @country = Country.find(params[:country_id])
        return not_found unless @country
        @cities = City.where state_id: @country.states
      elsif !params[:state_id].blank?
        @state = State.find(params[:state_id])
        return not_found unless @state
        @country = @state.country
        @cities = @state.cities
      elsif !params[:city_name].blank?
        cn = params[:city_name]
        @cities = City.where "name like ? or name like ?", "#{cn}%", "% #{cn}%"
      end
    end
    fresh_when @cities
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    @properties = Property.joins(:property_address).where(property_addresses:{
    city: @city.name, 
    state:  @city.state.name, 
    country:  @city.state.country.name}).all
    setup_search_form
    render "properties/index"
    fresh_when @properties
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.fetch(:city, {})
    end
end
