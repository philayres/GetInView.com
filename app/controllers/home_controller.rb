class HomeController < PublicController

  include SearchHandler
  def index
  
    setup_search_form
    fresh_when Property.last
  end
  

end
