class PageController < PublicController
# does not inherit ApplicationController
# therefore does not provide authentication


  def index
    return not_found
  end
  
  def get
    page = params[:id]
    return not_found if page.index(/\\|\./)
    render page
  end
  
end
