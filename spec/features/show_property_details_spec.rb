require 'rails_helper'

RSpec.feature "Show property details", type: :feature do
  
  
  it "requests shows a property details" do
    
    p = create :property
    visit property_path(p.id)
        
    expect(page).to have_content p.name
    
    expect(page).to have_content p.property_type_caption
    
    expect(page).to have_content p.property_address.as_single_line
    
  end
  
end
