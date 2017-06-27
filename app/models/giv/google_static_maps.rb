class Giv::GoogleStaticMaps  
  def self.gen_url latitude, longitude, width, height, zoom
  

 map = GoogleStaticMap.new(api_key: Rails.configuration.x.google_static_maps.api_key,
 :zoom => zoom, :center => MapLocation.new(latitude: latitude, longitude: longitude), width: width, height: height,
 markers: [
 MapMarker.new( location:
 MapLocation.new(latitude: latitude, longitude: longitude),
 color: 'green')
 ]
 ) 

 image_url = map.url("https")
  end
  
  

  def self.gen_address_url address, width, height, zoom
  

 map = GoogleStaticMap.new(api_key: Rails.configuration.x.google_static_maps.api_key,
 :zoom => zoom, :center => MapLocation.new(address: address), width: width, height: height,
 markers: [
 MapMarker.new( location:
 MapLocation.new(address: address),
 color: 'green')
 ]
 ) 

 image_url = map.url("https")
  end

end