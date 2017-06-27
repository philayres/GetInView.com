class CityInfo

  attr_accessor :country, :state, :city

  def find_by country_search, state_search, city_search
   
    @country = Country.where(name: country_search).first
    return unless country
    @state = country.states.where(name: state_search).first
    return unless state
    @city = state.cities.where(name: city_search).first
    return unless city
  
  end
  
  
  def self.url_for city_object
    ci = CityInfo.new
    ci.set_city city_object
    "/city_info/#{ci.country_name}/#{ci.state_name}/#{ci.city_name}"
  end

  def set_city city_object
    @city = city_object
    @state = city.state
    @country = state.country
  end


  def country_name
    return nil unless country
    country.name
  end 
  
  def state_name
    return nil unless state
    state.name
  end
  
  def city_name
    return nil unless city
    city.name
  end
  
  def country_filename
    return nil unless country_name
    country_name.downcase
  end
  
  def state_filename
    return nil unless state_name
    state_name.downcase.gsub(" ", "_").gsub(/^\\w/i, "")
  end
  
  def city_filename
    return nil unless city_name
    city_name.downcase.gsub(" ", "_").gsub(/^\\w/i, "")
  end
  
  def render_location
    return nil unless country_filename && state_filename && city_filename
    "city_info/#{country_filename}/#{state_filename}/#{city_filename}"
  end
 
  def file_location
    r=Rails.root.join("app/views/city_info/#{country_filename}/#{state_filename}/_#{city_filename}.html.erb").to_s
    #puts r
    r
  end

  def exists?
    File.exist? file_location
  end

  def updated_at
    return unless exists?
    File.mtime file_location
  end

end