class Giv::GooglePlace

  attr_accessor :json_result, :place_id, :rating, :price_level, :url, :status, :html_attributions

  
  def initialize place_id=nil
    self.place_id = place_id
    get_place
  end
  
  def get_place
    raise NoPlaceId unless place_id
    
    self.json_result = Rails.cache.fetch("google_place_result_#{place_id}") do
      uri = URI generate_api_url
      res = Net::HTTP.get(uri)
      return unless res
      res
    end
 #   self.json_result = res
    
    return nil unless self.json_result
    
    p = JSON.parse self.json_result
    self.status = p["status"]
    return unless self.status == "OK"
    self.html_attributions = p["html_attributions"]
    res = p["result"]
    self.rating = res["rating"]
    self.price_level = res["price_level"]
    self.url = res["url"]
    self.reviews = res["reviews"]
    self.status
  end
  
  def generate_api_url lang="en"
    "https://maps.googleapis.com/maps/api/place/details/json?key=#{api_key}&placeid=#{place_id}&language=#{lang}"
  end
  
  def api_key
    Rails.configuration.x.google_places_api.api_key
  end
  
  def reviews= json
    @reviews = []
    return unless json
    json.each do |a|
      r = Review.new
      @reviews.append r
      r.rating = a["rating"]
      r.text = a["text"]
      r.author_name = a["author_name"]
      r.time = Time.at(a["time"])
    end
  end
  
  def reviews
    @reviews
  end
  
  class NoPlaceId < Exception
  end
  
  class Review
    attr_accessor :rating, :author_name, :text, :time
  end

end