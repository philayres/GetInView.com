module Giv::GoogleStaticMapsHelper


  def map_img_tag latitude, longitude, width, height, options={}
    
    zoom = options[:zoom] || 10
    src = Giv::GoogleStaticMaps.gen_url latitude, longitude, width, height, zoom
    options[:src] = src
    inblock = "<div class=\"instruction\">#{options[:instructions]}</div>" if options[:instructions]
    unless options[:nolink]
      link = "<a href=\"https://www.google.com/maps/place/#{latitude},#{longitude}/@#{latitude},#{longitude},#{zoom}z\" target=\"givmaploc\">" 
      link = "<a href=\"#{@google_place.url}\" target=\"givmaploc\">" if @google_place && @google_place.url
      endlink = "</a>"
    end
    "#{link}#{inblock}<img src=\"#{src}\" width=\"#{width}\" height=\"#{height}\" />#{endlink}".html_safe
  end

  def map_address_img_tag address, width, height, options={}
    
    zoom = options[:zoom] || 10
    src = Giv::GoogleStaticMaps.gen_address_url address, width, height, zoom
    options[:src] = src    
    inblock = "<div class=\"instruction\">#{options[:instructions]}</div>" if options[:instructions]
    unless options[:nolink]
      link = "<a href=\"https://www.google.com/maps/place/#{address}/#{address},#{zoom}z\" target=\"givmaploc\">" 
      link = "<a href=\"#{@google_place.url}\" target=\"givmaploc\">" if @google_place && @google_place.url
      endlink = "</a>"
    end
    "#{link}#{inblock}<img src=\"#{src}\" width=\"#{width}\" height=\"#{height}\" />#{endlink}".html_safe
  end



private  
  def gen_url latitude, longitude, width, height, zoom
  

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
  
  

  def gen_address_url address, width, height, zoom
  

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