require 'rails_helper'

RSpec.describe "Searches location", type: :request do
  
  it "accepts a GET request with flag gps coordinates and a search term indicating that this is the current location to search" do
    get properties_path(property: {name: 'search your current location'}, location_latitude: '51.00001',  location_longitude: '0.10')
    expect(response).to have_http_status(200)
  end
  
end
