module PropertiesHelper
  
  def property_type_options value
    options_for_select(Property::PropertyTypes.map{|k,v| [v, k]}, value)
  end
  
  def property_type_display value
    Property::PropertyTypes[value.to_sym] unless value.blank?
  end
end
