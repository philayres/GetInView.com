require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  it "should show the home page" do
    get :index
    expect(response).to be_success
    
    expect(response).to render_template('index')
    
  
  end
  
  it "appears as a public page" do
    expect(HomeController <= PublicController).to be true 
  end
  
end
