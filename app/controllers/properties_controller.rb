class PropertiesController < PublicController
  before_action :set_property, only: [:show]
  include SearchHandler
  
  def index
  
    redirect_to "/" if params[:property].blank? || params[:property][:name].blank?
  
    @search_name = params[:property][:name].strip
    
    unless params[:location_latitude].blank? || params[:location_longitude].blank?
      @latitude = params[:location_latitude].strip
      @longitude = params[:location_longitude].strip
    end
  
    redirect_to "/" if (@search_name.blank? || @search_name.length < 2) && (@latitude.blank? || @longitude.blank?)

    setup_search_form
    @search_action_text = "Search again"

    if @search_name == @current_location_text
      latitude = @latitude.to_d
      longitude = @longitude.to_d
      #flash.notice = "invalid location request #{latitude}"
      #redirect_to "/" if latitude.to_s.to_d != @latitude || longitude != longitude
      radius = 1.0
      radius = params[:rad].to_f unless params[:rad].blank?
      
      radius = 2.0 if radius > 2.0
      radius = 0 if radius < 0
      
      @properties = Property.joins(:property_address).where(property_addresses: {latitude: latitude-radius..latitude+radius, longitude: longitude-radius..longitude+radius})
      
      @properties.reorder!("pow((property_addresses.latitude - #{latitude}), 2) + pow((property_addresses.longitude - #{longitude}), 2)")
      
    else
      
      @property.name = @search_name
    #  @properties = Property.all
    #  return
      @properties = Property.where('name like ? or name like ?', "#{@search_name}%", "% #{@search_name}%")
     # @properties += Property.joins(:property_address).where(property_addresses: {city: @search_name})
      @properties += Property.joins(:property_address).where('property_addresses.city like ? or property_addresses.city like ?', "#{@search_name}%", "% #{@search_name}%")
      @properties += Property.joins(:property_address).where('property_addresses.state like ? or property_addresses.state like ?', "#{@search_name}%", "% #{@search_name}%")
      
      
      @properties.uniq!
    
    end
    @title = "Accommodation found for #{@search_name}"
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  
    fresh_when @property
  
    @google_place = @property.google_place.result if @property.google_place
    @ad_slot = :top
    @title = "#{@property.name}: a #{@property.property_type_caption || 'lodging'} in #{@property.property_address.city} #{Country.full_name @property.property_address.country}"
    
    @description = @property.property_description.description if @property.property_description
    @description ||= "One of many properties listed in #{Country.full_name @property.property_address.country}"

    if @property.property_address.valid_gps?
      src = Giv::GoogleStaticMaps.gen_url @property.property_address.latitude, @property.property_address.longitude, 600, 400, 14
      
    else
    
      src = Giv::GoogleStaticMaps.gen_address_url "#{@property.property_address.address1},#{@property.property_address.city},#{@property.property_address.state},#{@property.property_address.country}", 600, 400, 14
    end
    @image = src
  end

  #

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.fetch(:property, {})
    end
end
