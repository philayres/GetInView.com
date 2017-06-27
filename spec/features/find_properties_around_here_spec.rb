require 'rails_helper'

RSpec.feature "Find Properties around current location", type: :feature do
  def fill_gps_form lat='51.0002', lng='0.0001'
    find('#new_property')
    within('#new_property') do
      fill_in 'enter hotel name, country, city, state, or', with: 'search your current location'      
    end
    llat = find('#location_latitude', visible: false)
    llat.set lat
    llng = find('#location_longitude', visible: false)
    llng.set lng
    
  end
  
  it "requests a search around the current location and finds none" do
    visit "/"
    
    fill_gps_form
    
    click_button 'Find a place to stay'
    expect(page).to have_content "Found 0 Accommodations"
  end
  
  it "requests a search around the current location and finds one" do
    visit "/"
    
    create :property
        
    fill_gps_form
    
    click_button 'Find a place to stay'
    expect(page).to have_content "Found 1 Accommodation"
  end
  
  
  it "requests a search around the current location and finds multiple" do
    visit "/"
    num = rand(2..12)
    num.times do
      create :property
    end
    
    fill_gps_form
    
    click_button 'Find a place to stay'
    expect(page).to have_content "Found #{num} Accommodation"
  end
end
