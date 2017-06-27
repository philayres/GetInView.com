module ICanHandler

  extend ActiveSupport::Concern
  


  def i_can_edit_properties
#TODO
    current_user.properties.length > 0
    logger.warn "Todo"

  end

end