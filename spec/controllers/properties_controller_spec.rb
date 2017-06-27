require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do

  it "should show a property page" do
    p = create :property
    get :show, params: {id: p.id}
    expect(response).to be_success
    
    expect(response).to render_template('show')
  end
  
  it "should show fail cleanly for an unknown property" do
    
    get :show, params: {id: 100000}
    expect(response).to be_not_found
  end
  
  it "appears as a public page" do
    expect(PropertiesController <= PublicController).to be true 
  end
  
end
