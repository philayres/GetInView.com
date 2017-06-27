module PropertyHandler
  
  extend ActiveSupport::Concern
  
  
  
  included do
    belongs_to :property, optional: false
    belongs_to :user, optional: false
    belongs_to @parent_type_symbol, optional: false if @parent_type_symbol
    
    scope :not_hidden, -> {where "hidden is null or hidden = false"}
  end
  
  module ClassMethods
  
    def parent_type_symbol
      @parent_type_symbol
    end
    
    def parent_type
      return Property unless @parent_type_symbol
      @parent_type_symbol.to_s.classify.constantize
    end
  end
  
  

end